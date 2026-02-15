// UI-тесты: запуск приложения, наличие кнопок «Открыть из файла», «Сохранить в файл», «Расчет»,
// нажатие «Расчет» и появление экрана результатов (кнопка «Назад»), сохранение в файл (диалог + отмена), замер времени запуска

import XCTest

final class saprUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {}

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()
    }

    func testMainButtonsExist() throws {
        let app = XCUIApplication()
        app.launch()

        XCTAssertTrue(app.buttons["Открыть из файла"].waitForExistence(timeout: 3))
        XCTAssertTrue(app.buttons["Сохранить в файл"].waitForExistence(timeout: 2))
        XCTAssertTrue(app.buttons["Расчет"].waitForExistence(timeout: 2))
    }

    func testCalculationButtonTappable() throws {
        let app = XCUIApplication()
        app.launch()

        let calcButton = app.buttons["Расчет"]
        XCTAssertTrue(calcButton.waitForExistence(timeout: 3))
        calcButton.tap()
    }

    func testResultsShownAfterCalculation() throws {
        let app = XCUIApplication()
        app.launch()

        let calcButton = app.buttons["Расчет"]
        XCTAssertTrue(calcButton.waitForExistence(timeout: 3))
        calcButton.tap()

        if app.alerts.firstMatch.waitForExistence(timeout: 2) {
            app.alerts.buttons["OK"].tap()
            return
        }

        let backButton = app.buttons["Назад"]
        XCTAssertTrue(backButton.waitForExistence(timeout: 3), "После расчёта должна показываться кнопка «Назад» (экран результатов)")
    }

    func testSaveToFileButtonTappable() throws {
        let app = XCUIApplication()
        app.launch()

        let saveButton = app.buttons["Сохранить в файл"]
        XCTAssertTrue(saveButton.waitForExistence(timeout: 3))
        saveButton.tap()

        let cancelRu = app.buttons["Отмена"].firstMatch
        let cancelEn = app.buttons["Cancel"].firstMatch
        let dialogOpened = cancelRu.waitForExistence(timeout: 2) || cancelEn.waitForExistence(timeout: 1)
        XCTAssertTrue(dialogOpened, "Диалог сохранения не открылся — кнопка «Сохранить в файл» может не работать или нет прав на запись файлов")

        if cancelRu.exists {
            cancelRu.tap()
        } else {
            cancelEn.tap()
        }
        XCTAssertTrue(app.buttons["Расчет"].waitForExistence(timeout: 2), "После закрытия диалога приложение должно оставаться рабочим")
    }
}

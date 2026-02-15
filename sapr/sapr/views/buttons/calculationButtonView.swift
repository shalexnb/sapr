// Кнопка «Расчет» и логика: проверка заделок → матрицы A/B → Гаусс → переход к результатам

import SwiftUI

func runCalculation(myVar: MyVar, getResults: Binding<Bool>) {
    if myVar.bbase[0] == false && myVar.bbase[1] == false {
        let baseAlert = NSAlert()
        baseAlert.messageText = "В конструкции нет жестких заделок"
        baseAlert.informativeText = "Добавьте хотя бы одну заделку"
        baseAlert.addButton(withTitle: "OK")
        baseAlert.runModal()
    } else {
        getResults.wrappedValue = true
        let A = createAMatr(myVar: myVar)
        let B = createBMatr(myVar: myVar)
        let sys = getForElimination(A: A, B: B, myVar: myVar)

        guard let sols = gaussEliminate(sys) else {
            fatalError("No solutions")
        }
        print(sols)
    }
}

struct CalculationButtonView: View {
    @ObservedObject var myVar: MyVar
    @Binding var getResults: Bool

    var body: some View {
        Button("Расчет") {
            runCalculation(myVar: myVar, getResults: $getResults)
        }
    }
}

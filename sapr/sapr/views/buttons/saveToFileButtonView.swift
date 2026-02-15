// Кнопка «Сохранить в файл» и функция: getToFile → NSSavePanel → запись в выбранный файл

import SwiftUI
import UniformTypeIdentifiers

func saveToFile(myVar: MyVar) {
    let str: String = getToFile(myVar: myVar)
    let savePanel = NSSavePanel()
    savePanel.canCreateDirectories = true
    savePanel.isExtensionHidden = true
    savePanel.allowsOtherFileTypes = true
    savePanel.title = "Сохранить файл"
    savePanel.message = "Выберите папку и имя."
    savePanel.nameFieldLabel = "Имя файла:"
    savePanel.nameFieldStringValue = "mycompmech"
    savePanel.allowedContentTypes = [.text]
    savePanel.allowedFileTypes = ["txt"]
    let response = savePanel.runModal()
    guard response == .OK, let saveURL = savePanel.url else { return }
    try? str.write(to: saveURL, atomically: true, encoding: .utf8)
}

struct SaveToFileButtonView: View {
    @ObservedObject var myVar: MyVar

    var body: some View {
        Button("Сохранить в файл") {
            saveToFile(myVar: myVar)
        }
    }
}

// Кнопка «Открыть из файла» и функция: NSOpenPanel → чтение текста → разбор в MyVar

import SwiftUI
import UniformTypeIdentifiers

/// Открывает диалог выбора файла, читает содержимое и заполняет myVar через getFromFile
func openFromFile(myVar: MyVar) {
    let openPanel = NSOpenPanel()
    openPanel.allowsMultipleSelection = false
    openPanel.canChooseDirectories = true
    openPanel.canCreateDirectories = false
    openPanel.canChooseFiles = true
    openPanel.allowedContentTypes = [.text]
    openPanel.allowsOtherFileTypes = true
    openPanel.isExtensionHidden = true
    let response = openPanel.runModal()
    guard response == .OK, let loadURL = openPanel.url else { return }
    try? myVar.text = String(contentsOf: loadURL)
    myVar.getFromFile(text: myVar.text)
    print(myVar.text)
}

struct OpenFromFileButtonView: View {
    @ObservedObject var myVar: MyVar

    var body: some View {
        Button("Открыть из файла") {
            openFromFile(myVar: myVar)
        }
    }
}


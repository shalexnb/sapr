// горизонтальная панель кнопок: «Открыть из файла», «Сохранить в файл», «Расчет»

import SwiftUI
import UniformTypeIdentifiers

struct buttonsView: View {
    @ObservedObject var myVar: MyVar
    @Binding var GetResults: Bool

    private var openFromFileButton: some View {
        OpenFromFileButtonView(myVar: myVar)
    }

    private var saveToFileButton: some View {
        SaveToFileButtonView(myVar: myVar)
    }

    private var calculationButton: some View {
        CalculationButtonView(myVar: myVar, getResults: $GetResults)
    }

    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            openFromFileButton
            saveToFileButton
            calculationButton
        }
    }
}

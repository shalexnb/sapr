// Кнопка «Назад» на экране результатов: сбрасывает GetResults и возвращает к вводу данных

import SwiftUI

struct backbutton: View {
    @Binding var GetResults: Bool
    var body: some View {
        Button("Назад") {
            GetResults = false
               
        }
    }
}


// Поле ввода допускаемого напряжения σдоп; при вводе отрицательного или нуля — корректировка (по умолчанию 1.6e8)

import SwiftUI

struct stressTableView: View {
    @ObservedObject var myVar: MyVar
    let formatter: NumberFormatter = {
            let formatter = NumberFormatter()
            formatter.numberStyle = .scientific
            return formatter
        }()
    var body: some View {
        VStack (alignment: .leading,
                spacing: -10) {
            Text("σдоп")
                .frame(width: 120)
                .padding()
                .frame(width: 120)
            TextField(" ", value: $myVar.stress, formatter: formatter)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                            .frame(width: 120)
                            .onSubmit {
                                greaterThan(va: &myVar.stress)
                            }
        }
    }
    /// va ≥ 0; при va == 0 подставляет 1.6e8.
    func greaterThan(va: inout Double) {
        if va < 0 {
            va = abs(va)
        }
        if va == 0 {
            va = 1.6e8
        }
    }
}


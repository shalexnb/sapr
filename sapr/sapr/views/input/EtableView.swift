// Поле ввода модуля упругости E; при вводе отрицательного или нуля — корректировка (abs, по умолчанию 2e11)

import SwiftUI

struct EtableView: View {
    @ObservedObject var myVar: MyVar
    let formatter: NumberFormatter = {
            let formatter = NumberFormatter()
            formatter.numberStyle = .scientific
            return formatter
        }()
    var body: some View {
        VStack (alignment: .leading,
                spacing: -10) {
            Text("E")
                .frame(width: 120)
                .padding()
                .frame(width: 120)
            TextField(" ", value: $myVar.E, formatter: formatter)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                            .frame(width: 120)
                            .onSubmit {
                                greaterThan(va: &myVar.E)
                            }
        }
    }
    /// va ≥ 0; при va == 0 подставляет 2e11.
    func greaterThan(va: inout Double) {
        if va < 0 {
            va = abs(va)
        }
        if va == 0 {
            va = 2e11
        }
    }
}
/*
struct Etable_Previews: PreviewProvider {
    static var previews: some View {
        Etable(E: MyVar.E)
    }
}
*/

// Колонка ввода площадей стержней A[0]…A[4]; при вводе обновляет prev и обнуляет следующие A при нуле

import SwiftUI

struct columnAview: View {
    @ObservedObject var myVar: MyVar

    let formatter: NumberFormatter = {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            return formatter
        }()
    var body: some View {
            VStack(
                alignment: .leading,
                spacing: -10
            ) {
                Text("A")
                    .frame(width: 120)
                    .padding()
                    .frame(width: 120)
                TextField(" ", value: $myVar.As[0], formatter: formatter)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding()
                                .frame(width: 120)
                                .onSubmit {
                                    equalZ(va: &myVar.As[0])
                                    greaterThan(va: &myVar.As[0], boo: &myVar.prev[0])
                                }
                TextField(" ", value: $myVar.As[1], formatter: formatter)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding()
                                .frame(width: 120)
                                .onSubmit {
                                    greaterThan(va: &myVar.As[1], boo: &myVar.prev[0])
                                    prev(va: &myVar.As[1], boo: myVar.prev[0])
                                    changeNext(va: myVar.As[1], other: &myVar.As[4], boo: &myVar.prev[4])
                                    changeNext(va: myVar.As[1], other: &myVar.As[3], boo: &myVar.prev[3])
                                    changeNext(va: myVar.As[1], other: &myVar.As[2], boo: &myVar.prev[2])
                                }

                TextField(" ", value: $myVar.As[2], formatter: formatter)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding()
                                .frame(width: 120)
                                .onSubmit {
                                    greaterThan(va: &myVar.As[2], boo: &myVar.prev[1])
                                    prev(va: &myVar.As[2], boo: myVar.prev[1])
                                    changeNext(va: myVar.As[2], other: &myVar.As[3], boo: &myVar.prev[3])
                                    changeNext(va: myVar.As[2], other: &myVar.As[4], boo: &myVar.prev[4])
                                }

                TextField(" ", value: $myVar.As[3], formatter: formatter)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding()
                                .frame(width: 120)
                                .onSubmit {
                                    greaterThan(va: &myVar.As[3], boo: &myVar.prev[2])
                                    prev(va: &myVar.As[3], boo: myVar.prev[2])
                                    changeNext(va: myVar.As[3], other: &myVar.As[4], boo: &myVar.prev[4])
                                }

                TextField(" ", value: $myVar.As[4], formatter: formatter)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding()
                                .frame(width: 120)
                                .onSubmit {
                                    greaterThan(va: &myVar.As[4], boo: &myVar.prev[3])
                                    
                                }


            }
    }
    /// va ≥ 0; если va > 0, boo = 1, иначе 0
    func greaterThan(va: inout Double, boo: inout Double) {
        if va < 0 {
            va = abs(va)
        }
        if va > 0 {
            boo = 1
        } else {
            boo = 0
        }
    }
    /// Замена нуля на 20 (значение по умолчанию для A)
    func equalZ(va: inout Double) {
        if va == 0{
            va = 20
        }
    }
    /// Если boo == 0, обнуляет va
    func prev(va: inout Double, boo: Double) {
        if boo == 0 {
            va = 0
        }
    }
    /// Если va == 0, обнуляет other и boo
    func changeNext(va: Double, other: inout Double, boo: inout Double) {
        if va == 0{
            other = 0
            boo = 0
        }
    }
}
/*
struct columnAview_Previews: PreviewProvider {
    static var previews: some View {
        columnAview()
    }
}
*/

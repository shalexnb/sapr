// Колонка ввода длин стержней L[0]…L[4]; при вводе обновляет prev и обнуляет следующие L при нуле

import Foundation
import SwiftUI

struct columnLview: View {
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
                Text("L")
                    .frame(width: 120)
                    .padding()
                TextField(" ", value: $myVar.Ls[0], formatter: formatter)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding()
                                .frame(width: 120)
                                .onSubmit {
                                    equalZ(va: &myVar.Ls[0])
                                    greaterThan(va: &myVar.Ls[0], boo: &myVar.prev[0])
                                  
                                }
                
                TextField(" ", value: $myVar.Ls[1], formatter: formatter)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding()
                                .frame(width: 120)
                                .onSubmit {
                                    greaterThan(va: &myVar.Ls[1], boo: &myVar.prev[1])
                                    prev(va: &myVar.Ls[1], boo: myVar.prev[0])
                                    changeNext(va: myVar.Ls[1], other: &myVar.Ls[4], boo: &myVar.prev[4])
                                    changeNext(va: myVar.Ls[1], other: &myVar.Ls[3], boo: &myVar.prev[3])
                                    changeNext(va: myVar.Ls[1], other: &myVar.Ls[2], boo: &myVar.prev[2])
                                }

                TextField(" ", value: $myVar.Ls[2], formatter: formatter)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding()
                                .frame(width: 120)
                                .onSubmit {
                                    greaterThan(va: &myVar.Ls[2], boo: &myVar.prev[2])
                                    prev(va: &myVar.Ls[2], boo: myVar.prev[1])
                                    changeNext(va: myVar.Ls[2], other: &myVar.Ls[3], boo: &myVar.prev[3])
                                    changeNext(va: myVar.Ls[2], other: &myVar.Ls[4], boo: &myVar.prev[4])
                                
                                }

                TextField(" ", value: $myVar.Ls[3], formatter: formatter)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding()
                                .frame(width: 120)
                                .onSubmit {
                                    greaterThan(va: &myVar.Ls[3], boo: &myVar.prev[3])
                                    prev(va: &myVar.Ls[3], boo: myVar.prev[2])
                                    changeNext(va: myVar.Ls[3], other: &myVar.Ls[4], boo: &myVar.prev[4])
                                
                                }

                TextField(" ", value: $myVar.Ls[4], formatter: formatter)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding()
                                .frame(width: 120)
                                .onSubmit {
                                    greaterThan(va: &myVar.Ls[4], boo: &myVar.prev[4])
                                    prev(va: &myVar.Ls[4], boo: myVar.prev[3])
                                
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
    /// Замена нуля на 100 (чтобы первое поле L не было 0)
    func equalZ(va: inout Double) {
        if va == 0{
            va = 100
        }
    }
    /// Если boo == 0, обнуляет va (каскад при обнулении предыдущего)
    func prev(va: inout Double, boo: Double) {
        if boo == 0 {
            va = 0
        }
    }
    /// Если va == 0, обнуляет other и boo (обнуление следующих полей)
    func changeNext(va: Double, other: inout Double, boo: inout Double) {
        if va == 0{
            other = 0
            boo = 0
        }
    }
    
}
/*
struct rowview_Previews: PreviewProvider {
    static var previews: some View {
        columnLview(prev: MyVar.prev, Ls1: MyVar.Ls[0], Ls2: MyVar.Ls[1], Ls3: MyVar.Ls[2], Ls4: MyVar.Ls[3], Ls5: MyVar.Ls[4])
    }
    
}
*/

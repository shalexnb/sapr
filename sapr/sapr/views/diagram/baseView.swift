// Переключатели «Жесткая заделка»: слева и справа; синхронизация bbase и base

import SwiftUI

struct baseView: View {
    @ObservedObject var myVar: MyVar
  
    var body: some View {
        VStack(alignment: .center, spacing: -10) {
            Text("Жесткая заделка")
                .padding()
            HStack (alignment: .top,
                    spacing: 10){
                
                Toggle("Слева", isOn: $myVar.bbase[0])
                    .onChange(of: myVar.bbase[0]) {_ in
                        change(bbase: myVar.bbase[0], base: &myVar.base[0])
                        print("слева \(myVar.base[0])")
                }
                Toggle("Справа", isOn: $myVar.bbase[1])
                    .onChange(of: myVar.bbase[1]) {_ in
                        change(bbase: myVar.bbase[1], base: &myVar.base[1])
                        print("Справа \(myVar.base[1])")
                }
            }
        }
    }
    /// Записывает в base 1 или 0 по значению bbase (для заделок)
    func change(bbase: Bool, base: inout Double) {
        if bbase {
            base = 1
        } else {
            base = 0
        }
    }
    func change1(bbase: inout Bool, base: Double) {
        if base == 1 {
            bbase = true
        } else {
            bbase = false
        }
    }
}
/*
struct baseView_Previews: PreviewProvider {
    static var previews: some View {
        baseView(base: MyVar.base)
    }
}
*/

// Экран ввода данных: панель кнопок, колонки L/A/q/F, E, σдоп, заделки и схема стержней (barsView)

import SwiftUI

struct tableview: View {
    @State var cod: String
    @ObservedObject var myVar: MyVar
    @Binding var GetResults: Bool
    var body: some View {
        VStack (
            alignment: .center,
            spacing: -10
        ){
            buttonsView(myVar: myVar, GetResults: $GetResults)
            HStack(
                alignment: .top,
                spacing: -10
            ) {
                
                columnLview(myVar: myVar)
                columnAview(myVar: myVar)
                columnqview(myVar: myVar)
                VStack(alignment: .leading, spacing: -10) {
                    Ftable(myVar: myVar)
                    HStack(
                        alignment: .center,
                        spacing: 10
                    ){
                        EtableView(myVar: myVar)
                        stressTableView(myVar: myVar)
                        baseView(myVar: myVar)
                        
                        
                    }
                }
                
            }
            Spacer()
            barsView(myVar: myVar)
        }
    }
    
}
/*
struct tableview_Previews: PreviewProvider {
    static var previews: some View {
        tableview()
    }
}
*/


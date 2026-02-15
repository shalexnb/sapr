// Таблица результатов расчёта: число стержней и колонки N0, NL, u0, uL, uExtr, LExtr, σ0, σL, >σдоп

import SwiftUI

struct resultTableView: View {
    var myVar: MyVar
    var body: some View {
        let count: Int = myVar.getAmount()
        let res = getRes(myVar: myVar)
        
        VStack(alignment: .center, spacing: 0) {
            Text("Число стержней в конструкции: \(count)")
            Table(res) {
                TableColumn("№ стержня", value: \.numOfBarString)
                TableColumn("N0", value: \.N0String)
                TableColumn("NL", value: \.NLString)
                TableColumn("u0", value: \.u0String)
                TableColumn("uL", value: \.uLString)
                TableColumn("uExtr", value: \.uMaxString)
                TableColumn("LExtr", value: \.LextrString)
                TableColumn("σ0", value: \.stress0String)
                TableColumn("σL", value: \.stressLString)
                TableColumn(">σдоп", value: \.greaterThanAllowedString)
            }
            
            }
            
        }
        
    /// Формирует массив resBar по всем активным стержням для отображения в таблице
    func getRes (myVar: MyVar) -> [resBar] {
        var res: [resBar] = [resBar(myVar: myVar, idb: 0)]
        let c: Int = myVar.getAmount() - 1
        
        if c == 0 {
            return res
        }
        
        for i in 1...c {
            res.append(resBar(myVar: myVar, idb: i))
        }
        return res
    }
    }
    


struct resultTableView_Previews: PreviewProvider {
    static var previews: some View {
        resultTableView(myVar: MyVar())
    }
}

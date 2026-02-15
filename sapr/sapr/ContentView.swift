// Главный экран: переключает ввод данных (tableview) и экран результатов (finalView).
// GetResults — флаг перехода к результатам после нажатия «Расчет».

import SwiftUI
import CoreData

@available(macOS 13.0, *)
struct ContentView: View {
    @ObservedObject var myVar: MyVar = MyVar()
    @Environment(\.openWindow) var openWindow
    @State var GetResults: Bool = false
    @State var cod: String = getToFile(myVar: MyVar())
    
    var body: some View {
        if !GetResults {
            tableview(cod: cod, myVar: myVar, GetResults: $GetResults)
        } else {
            finalView(myVar: myVar, GetResults: $GetResults)
        }
        
        /*
        tableview(cod: cod, myVar: myVar)
            .padding()
            .frame(width: 1000, height: 500.0)
            */
        
    }
    
    
}
/*
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

*/

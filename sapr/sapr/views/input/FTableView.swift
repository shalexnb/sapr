// Колонка ввода сосредоточенных сил F[0]…F[5] в узлах

import SwiftUI

struct Ftable: View {
    @ObservedObject var myVar: MyVar
    let formatter: NumberFormatter = {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            return formatter
        }()

    var body: some View {
        VStack (alignment: .leading, spacing: -10){
            Text("F")
                .frame(width: 120)
                .padding()
                .frame(width: 120)
            HStack(alignment: .top,
                   spacing: -10) {
                TextField(" ", value: $myVar.F[0], formatter: formatter)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding()
                                .frame(width: 120)

                TextField(" ", value: $myVar.F[1], formatter: formatter)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding()
                                .frame(width: 120)
                               
                TextField(" ", value: $myVar.F[2], formatter: formatter)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .padding()
                                    .frame(width: 120)
                                   
                
                TextField(" ", value: $myVar.F[3], formatter: formatter)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .padding()
                                    .frame(width: 120)
                                   
                
                TextField(" ", value: $myVar.F[4], formatter: formatter)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .padding()
                                    .frame(width: 120)
                                   
                TextField(" ", value: $myVar.F[5], formatter: formatter)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .padding()
                                    .frame(width: 120)
                                   
            }
        }
    }
    
}
/*
struct FAndE_Previews: PreviewProvider {
    static var previews: some View {
        Ftable(F: MyVar.F)
    }
}
*/

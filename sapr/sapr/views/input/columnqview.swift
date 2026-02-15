// Колонка ввода распределённых нагрузок q[0]…q[4] (по одному полю на стержень)

import SwiftUI

struct columnqview: View {
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
                Text("q")
                    .frame(width: 120)
                    .padding()
                    .frame(width: 120)
                TextField(" ", value: $myVar.qs[0], formatter: formatter)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding()
                                .frame(width: 120)

                TextField(" ", value: $myVar.qs[1], formatter: formatter)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding()
                                .frame(width: 120)

                TextField(" ", value: $myVar.qs[2], formatter: formatter)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding()
                                .frame(width: 120)
                               
                TextField(" ", value: $myVar.qs[3], formatter: formatter)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding()
                                .frame(width: 120)
                               
                TextField(" ", value: $myVar.qs[4], formatter: formatter)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding()
                                .frame(width: 120)
                              

            }
    }
}
/*
struct columnqview_Previews: PreviewProvider {
    static var previews: some View {
        columnqview(qs: MyVar.qs)
    }
}
*/

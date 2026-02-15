import SwiftUI

struct finalView: View {
    @State var myVar: MyVar
    @Binding var GetResults: Bool
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Spacer()
            backbutton(GetResults: $GetResults)
            resultTableView(myVar: myVar)
            
        }
    }
}


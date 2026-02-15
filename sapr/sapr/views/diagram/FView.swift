// Отображение сосредоточенной силы на схеме: значение и стрелка влево/вправо в зависимости от знака

import SwiftUI

struct FView: View {
    let right: Bool
    let value: Double
    var body: some View {
        
        VStack(alignment: .center, spacing: -5){
            Text(String(format: "%.2f", value))
                .foregroundColor(.black)
            if right {
                Image(systemName: "arrow.right").renderingMode(.original)
                    .foregroundColor(Color(.blue))
                    .font(.system(size: 25))
            } else {
                Image(systemName: "arrow.left").renderingMode(.original)
                    .foregroundColor(Color(.blue))
                    .font(.system(size: 25))
            }
        }
    }
}

struct FDraw_Previews: PreviewProvider {
    static var previews: some View {
        FView(right: true, value: 2)
    }
}

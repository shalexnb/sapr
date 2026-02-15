// Отображение распределённой нагрузки q на схеме: значение и ряд стрелок влево/вправо по длине стержня

import SwiftUI

struct qView: View {
    let width: Double
    let right: Bool
    let am: Double
    
    var body: some View {
        let amount: Int = (floor(width / 20).isNaN || floor(width / 20).isInfinite || floor(width / 16) < 0) ? 15 : Int(floor(width / 20))
        
  
        VStack(alignment: .center, spacing: -5){
            Text(String(format: "%.2f", am))
                .foregroundColor(.black)
                if right {
                    HStack(alignment: .center, spacing: -3) {
                        ForEach(1...amount, id: \.self) {_ in
                            Image(systemName: "arrow.right").renderingMode(.original)
                                .foregroundColor(Color(.black))
                                .font(.system(size: 15))
                        }
                    }
                }
                else {
                    HStack(alignment: .center, spacing: -3) {
                        ForEach(1...amount, id: \.self) {_ in
                            Image(systemName: "arrow.left").renderingMode(.original)
                                .foregroundColor(Color(.black))
                                .font(.system(size: 15))
                        }
                    }
                }
            }
        }
        
        
    
}

struct qDraw_Previews: PreviewProvider {
    static var previews: some View {
        qView(width: 100, right: false, am: 20)
    }
}

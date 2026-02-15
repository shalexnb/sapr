// Схема стержневой конструкции: прямоугольники (L, A), заделки, нагрузки q и F
// drawFirstRect / drawMiddleRect / drawLastRect — первый, средние и последний стержень с подписями и узлами

import Foundation
import SwiftUI

struct barsView: View {
    @ObservedObject var myVar: MyVar
    
    var body: some View {
        HStack(alignment: .center,
               spacing: -1)
        {
            drawFirstRect(myVar: myVar, indL: 100, indA: 30)
            if myVar.getAmount() > 2{
                
                drawMiddleRect(myVar: myVar, indL: 100, indA: 30, ind: 1)
                if myVar.getAmount() > 3 {
                    drawMiddleRect(myVar: myVar, indL: 100, indA: 30, ind: 2)
                }
                if myVar.getAmount() > 4 {
                    drawMiddleRect(myVar: myVar, indL: 100, indA: 30, ind: 3)
                }
            }
            if myVar.getAmount() > 1 {
                drawLastRect(myVar: myVar, indL: 100, indA: 30)
            }
            
        }
        .padding()
        .background(Rectangle().frame(height: 200)
          .foregroundColor(.gray))
    }
    /// Рисует первый стержень: заделка слева (если есть), прямоугольник, q, F, нумерация узлов
    @ViewBuilder func drawFirstRect(myVar: MyVar, indL: Double, indA: Double) -> some View{
        let L: Double = myVar.comparativeL()[0] * indL
        let A: Double = myVar.comparativeA()[0] * indA
        
        
        VStack(alignment: .center, spacing: 0){
            Text("L = " + String(format: "%.2f", myVar.Ls[0]) + ", \nA = " + String(format: "%.2f", myVar.As[0]))
            VStack(alignment: .trailing, spacing: -20){
                VStack(alignment: .leading, spacing: 0){
                    HStack(alignment: .center,
                           spacing: -4) {
                        if myVar.bbase[0] {
                            VStack (alignment: .leading,
                                    spacing: 7) {
                                Rectangle().frame(width: 20, height: 2).border(.black, width: 1).rotationEffect(.degrees(45))
                                Rectangle().frame(width: 20, height: 2).border(.black, width: 1).rotationEffect(.degrees(45))
                                Rectangle().frame(width: 20, height: 2).border(.black, width: 1).rotationEffect(.degrees(45))
                                Rectangle().frame(width: 20, height: 2).border(.black, width: 1).rotationEffect(.degrees(45))
                            }
                        }
                        ZStack(alignment: .leading) {
                            
                            ZStack(alignment: .trailing) {
                                ZStack(alignment: .center) {
                                    
                                    Rectangle()
                                        .fill(.white)
                                        .frame(width: L, height: A).border(.black, width: 1)
                                    
                                    if myVar.qs[0] != 0 {
                                        qView(width: L, right: myVar.qRight(ind: 0), am: myVar.qs[0])
                                    }
                                }
                                if myVar.getAmount() <= 2 {
                                    if myVar.F[1] != 0 {
                                        FView(right: myVar.FRight(ind: 1), value: myVar.F[1])
                                    }
                                }
                                
                            }
                            
                            if myVar.F[0] != 0 {
                                FView(right: myVar.FRight(ind: 0), value: myVar.F[0])
                            }
                            
                            
                        }
                        
                        if myVar.getAmount() == 1 {
                            if myVar.bbase[1] {
                                VStack (alignment: .center,
                                        spacing: 7) {
                                    Rectangle().frame(width: 20, height: 2).border(.black, width: 1).rotationEffect(.degrees(45))
                                    Rectangle().frame(width: 20, height: 2).border(.black, width: 1).rotationEffect(.degrees(45))
                                    Rectangle().frame(width: 20, height: 2).border(.black, width: 1).rotationEffect(.degrees(45))
                                    Rectangle().frame(width: 20, height: 2).border(.black, width: 1).rotationEffect(.degrees(45))
                                }
                            }
                        }
                        
                    }
                    ZStack(alignment: .center) {
                        Rectangle().frame(width: 10, height: 20).border(.black, width: 1)
                        Text("\(1)")
                            .foregroundColor(.black)
                    }
                    
                }
                ZStack(alignment: .center) {
                    Rectangle().frame(width: 10, height: 20).border(.black, width: 1)
                    Text("\(2)")
                        .foregroundColor(.black)
                }
            }
        }
        
    }
    /// Рисует крайний стержень: прямоугольник, q, F справа, заделка справа (если есть)
    @ViewBuilder func drawLastRect(myVar: MyVar, indL: Double, indA: Double) -> some View {
        let am: Int = myVar.getAmount() - 1
        let L: Double = myVar.comparativeL()[am] * indL
        let A: Double = myVar.comparativeA()[am] * indA
        
        
        VStack(alignment: .center, spacing: 0){
            Text("L = " + String(format: "%.2f", myVar.Ls[am]) + ", \nA = " + String(format: "%.2f", myVar.As[am]))
            VStack(alignment: .trailing, spacing: 0){
                HStack(alignment: .center,
                       spacing: -4) {

                    ZStack(alignment: .trailing) {
                        ZStack(alignment: .center) {
                            
                            Rectangle()
                                .fill(.white)
                                .frame(width: L, height: A).border(.black, width: 1)
                            
                            if myVar.qs[am] != 0 {
                                qView(width: L, right: myVar.qRight(ind: am), am: myVar.qs[am])
                            }
                        }
                        if myVar.F[am+1] != 0 {
                            FView(right: myVar.FRight(ind: am+1), value: myVar.F[am+1])
                        }
                    }
                    
                    if myVar.bbase[1] {
                        VStack (alignment: .center,
                                spacing: 7) {
                            Rectangle().frame(width: 20, height: 2).border(.black, width: 1).rotationEffect(.degrees(45))
                            Rectangle().frame(width: 20, height: 2).border(.black, width: 1).rotationEffect(.degrees(45))
                            Rectangle().frame(width: 20, height: 2).border(.black, width: 1).rotationEffect(.degrees(45))
                            Rectangle().frame(width: 20, height: 2).border(.black, width: 1).rotationEffect(.degrees(45))
                        }
                    }
                    
                }
                ZStack(alignment: .center) {
                    Rectangle().frame(width: 10, height: 20).border(.black, width: 1)
                    Text("\(myVar.getAmount() + 1)")
                        .foregroundColor(.black)
                }
            }
        }
        
        }
        
    }
    

    /// Рисует средний стержень: прямоугольник, q, F по краям, номер узла
    @ViewBuilder func drawMiddleRect(myVar: MyVar, indL: Double, indA: Double, ind: Int) -> some View {
        let L: Double = myVar.comparativeL()[ind] * indL
        let A: Double = myVar.comparativeA()[ind] * indA
        
        
        VStack(alignment: .center, spacing: 0){
            Text("L = " + String(format: "%.2f", myVar.Ls[ind]) +   ", \nA = " + String(format: "%.2f", myVar.As[ind]))
            VStack(alignment: .trailing, spacing: 0){
                ZStack(alignment: .leading) {
                    
                    ZStack(alignment: .trailing) {
                        ZStack(alignment: .center) {
                            
                            Rectangle()
                                .fill(.white)
                                .frame(width: L, height: A).border(.black, width: 1)
                            
                            if myVar.qs[ind] != 0 {
                                qView(width: L, right: myVar.qRight(ind: ind), am: myVar.qs[ind])
                            }
                        }
                        if myVar.F[ind + 1] != 0 && ((ind) == (myVar.getAmount() - 2)) {
                            FView(right: myVar.FRight(ind: ind + 1), value: myVar.F[ind + 1])
                        }
                    }
                    if myVar.F[ind] != 0 {
                        FView(right: myVar.FRight(ind: ind), value: myVar.F[ind])
                    }
                    
                }
                ZStack(alignment: .center) {
                    Rectangle().frame(width: 10, height: 20).border(.black, width: 1)
                    Text("\(ind+2)")
                        .foregroundColor(.black)
                }
            }
        }
    }
    


struct actualBars_Previews: PreviewProvider {
    static var previews: some View {
        barsView(myVar: MyVar())
    }
}

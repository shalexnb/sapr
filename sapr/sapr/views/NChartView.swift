// График продольного усилия N по стержню: линейный участок от N0 до NL 

import SwiftUI
import Charts

@available(macOS 13.0, *)
struct NChartView: View {
    var myVar: MyVar
    var ind: Int
    var body: some View {
        let A = createAMatr(myVar: myVar)
        let B = createBMatr(myVar: myVar)
        let sys = getForElimination(A: A, B: B, myVar: myVar)

        let sols = gaussEliminate(sys)!
        var n = getmidlN(sols: sols, myVar: myVar, ind: ind)
        
        let data: [Udata] = [Udata(x: 0, y: n.N0), Udata(x: myVar.Ls[ind], y: n.NL)]
        
        ZStack (alignment: .topTrailing){
            VStack {
                Chart {
                    ForEach(data) { datum in
                        LineMark(x: .value("L", datum.x), y: .value("N", datum.y))
                    }
                }
                .chartYAxis(.hidden)
                .chartXAxis(.hidden)
                .drawingGroup(opaque: true, colorMode: .linear)
            }
            //Text("\(String(format: "%.3f", n.NL))")
        }
    }
}

@available(macOS 13.0, *)
struct NChartView_Previews: PreviewProvider {
    static var previews: some View {
        NChartView(myVar: MyVar(), ind: 0)
    }
}

// График перемещений u по стержню: точки из UdataForChart, LineMark, подпись координат при наведении

import SwiftUI
import Charts

@available(macOS 13.0, *)
struct UChartView: View {
    var myVar: MyVar
    var ind: Int
    @State private var xco: Float = 0
    @State private var yco: Float = 0
    var body: some View {
        let chData: [Udata] = UdataForChart(myvar: myVar, ind: ind)
        
        ZStack (alignment: .topTrailing) {
            VStack {
                        Chart {
                            ForEach(chData) { item in
                                LineMark(
                                    x: .value("x", item.x),
                                    y: .value("y", item.y)
                                )
                            }
                        }
                        .frame(width: 600)
                        .chartXAxis(.visible)
                        .chartYAxis(.visible)
                        .onHover() {_ in
                            
                        }
            }
            Text("L: " + String(xco) + " u: " + String(yco))
        }
    }
}

@available(macOS 13.0, *)
struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        UChartView(myVar: MyVar(), ind: 0)
    }
}

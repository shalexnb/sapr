// Данные для графиков: массив точек по стержню для построения графика перемещений
// Udata — точка на графике; UdataForChart — заполняет массив для стержня ind

import Foundation

func UdataForChart(myvar: MyVar, ind: Int) -> [Udata] {
    let A = createAMatr(myVar: myvar)
    let B = createBMatr(myVar: myvar)
    let sys = getForElimination(A: A, B: B, myVar: myvar)
    let am = myvar.getAmount()
    
    guard let sols = gaussEliminate(sys) else {
      fatalError("No solutions")
    }
    var ud: [Udata] = [Udata(x: 0, y: quadratic(sols: sols, myVar: myvar, ind: ind, x: 0))]
    
    let step: Double = myvar.Ls[ind] / 1000
    
    for i in stride(from: step, to: myvar.Ls[ind], by: step) {
        ud.append(Udata(x: i, y: quadratic(sols: sols, myVar: myvar, ind: ind, x: i)))
    }
    
    return ud
}


struct Udata: Identifiable {
    let id = UUID()
    let x: Double
    let y: Double
    
    init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }
}

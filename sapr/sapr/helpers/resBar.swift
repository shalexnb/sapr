// Модель одной строки результатов: N0/NL, напряжения, перемещения u0/uL/uMax, экстремум
// Используется в resultTableView; вычисления через createAMatr, gaussEliminate, getmidlN, quadratiс

import Foundation

/// Результаты по одному стержню: усилия, напряжения, перемещения и признак превышения σдоп
struct resBar: Identifiable {
    let id = UUID()
    let numOfBar: Int
    let N0: Double
    let NL: Double
    
    let stress0: Double
    let stressL: Double
    let greaterThanAllowed: Bool
    
    let u0: Double
    let uL: Double
    let uMax: Double
    let extrU: Double
    let extrL: Double
    
    init(myVar: MyVar, idb: Int) {
        let A = createAMatr(myVar: myVar)
        let B = createBMatr(myVar: myVar)
        let sys = getForElimination(A: A, B: B, myVar: myVar)

        guard let sols = gaussEliminate(sys) else {
          fatalError("No solutions")
        }
        let n = getmidlN(sols: sols, myVar: myVar, ind: idb)
        
        numOfBar = idb + 1
        N0 = n.N0
        NL = n.NL
        
        stress0 = N0 / myVar.As[idb]
        stressL = NL / myVar.As[idb]
        if abs(stress0) > myVar.stress || abs(stressL) > myVar.stress {
            greaterThanAllowed = true
        } else {
            greaterThanAllowed = false
        }
        
        var extr = solveQuadratic(sols: sols, myVar: myVar, ind: idb)
        u0 = quadratic(sols: sols, myVar: myVar, ind: idb, x: 0)
        
        if idb == (myVar.getAmount()-1) && myVar.bbase[1] {
            uL = 0
        } else {
            uL = quadratic(sols: sols, myVar: myVar, ind: idb, x: myVar.Ls[idb])
        }
        if extr.L.isInfinite || extr.u.isInfinite || extr.L > myVar.Ls[idb] {
            extr.u = Double.nan
            extr.L = Double.nan
        }
        
        extrU = extr.u
        extrL = extr.L / myVar.Ls[idb]
        
        uMax = extrU
        
        
    }
}


extension resBar {
    
    var numOfBarString: String {
        String(numOfBar)
    }
    var N0String: String {
        String(format: "%e", N0)
    }
    var NLString: String {
        String(format: "%e", NL)
    }
    var stress0String: String {
        String(format: "%e", stress0)
    }
    var stressLString: String {
        String(format: "%e", stressL)
    }
    var greaterThanAllowedString: String {
        String(greaterThanAllowed)
    }
    var u0String: String {
        return String(format: "%e", u0)

    }
    var uLString: String {
        return String(format: "%e", uL)
    }
    var uMaxString: String {
        String(format: "%e", uMax)
    }
    var LextrString: String {
        String(format: "%3f", extrL)
    }
}

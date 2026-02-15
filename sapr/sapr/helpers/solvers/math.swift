// Решатель МКЭ: матрица жёсткости A, вектор B, сборка СЛАУ, метод Гаусса
// createAMatr/createBMatr — по данным MyVar; getForElimination — расширенная матрица; gaussEliminate — решение
// getmidlN, getN — продольные усилия; solveQuadratic, quadratic — перемещения по стержню

import Foundation

/// Собирает матрицу жёсткости системы (учёт заделок bbase)
func createAMatr(myVar: MyVar) -> [[Double]] {
    let am = Int(myVar.getAmount() - 1)
    var A: [[Double]]
    if am == 0 {
        A = [[0,0],
             [0,0]]
    } else if am == 1 {
        A = [[0,0,0],
             [0,0,0],
             [0,0,0]]
    } else if am == 4 {
        A = [[0,0,0,0,0,0],
             [0,0,0,0,0,0],
             [0,0,0,0,0,0],
             [0,0,0,0,0,0],
             [0,0,0,0,0,0],
             [0,0,0,0,0,0]]
    } else if am == 3 {
        A = [[0,0,0,0,0],
             [0,0,0,0,0],
             [0,0,0,0,0],
             [0,0,0,0,0],
             [0,0,0,0,0]]
    } else {
        A = [[0,0,0,0],
             [0,0,0,0],
             [0,0,0,0],
             [0,0,0,0]]
    }
     
    var betterAs: [Double] = myVar.As
    var betterLs: [Double] = myVar.Ls

    
    if am == 4 {
        
    } else {
        for i in am+1...4 {
            betterAs[i] = 0
            betterLs[i] = 0
        }
    }
    
    A[0][0] = (myVar.E * myVar.As[0]) / myVar.Ls[0]
    A[1][0] = -((myVar.E * myVar.As[0]) / myVar.Ls[0])
    A[0][1] = -((myVar.E * myVar.As[0]) / myVar.Ls[0])
    
    for i in 1...am+1 {
        if i == am+1 {
            A[i][i] = (myVar.E * myVar.As[i-1]) / myVar.Ls[i-1]
            break
        }
        A[i][i] = (myVar.E * myVar.As[i]) / myVar.Ls[i] + ((myVar.E * myVar.As[i-1]) / myVar.Ls[i-1])
        A[i][i+1] = -((myVar.E * myVar.As[i]) / myVar.Ls[i])
        A[i+1][i] = -((myVar.E * myVar.As[i]) / myVar.Ls[i])
        if A[i][i].isInfinite {
            A[i][i] = 0
        }
        if A[i+1][i].isInfinite {
            A[i+1][i] = 0
        }
        if A[i][i+1].isInfinite {
            A[i][i+1] = 0
        }

    }
    
    if myVar.bbase[0] == true {
        for i in 0...am+1 {
            A[i][0] = 0
            A[0][i] = 0
        }
        A[0][0] = 1
    }
    if myVar.bbase[1] == true {
        for i in 0...am+1 {
            A[i][am+1] = 0
            A[am+1][i] = 0
        }
        A[am+1][am+1] = 1
    }
        
    return A
}

/// Вектор правых частей (узловые нагрузки от F и q)
func createBMatr(myVar: MyVar) -> [Double] {
    var B: [Double] = [Double](repeating: 0, count: myVar.getAmount() + 1)
    var betterFs: [Double] = myVar.F
    var betterqs: [Double] = myVar.qs
    let am = myVar.getAmount()
    
    if am < 5 {
        for i in am...4 {
            betterqs[i] = 0
            betterFs[i+1] = 0
        }
    }
    B[0] = myVar.F[0] + (myVar.qs[0] * myVar.Ls[0]) / 2
    if am > 1 {
        for i in 1...am-1 {
            B[i] = myVar.F[i] + (myVar.qs[i-1] * myVar.Ls[i-1]) / 2 + (myVar.qs[i] * myVar.Ls[i]) / 2
        }
        
        B[am] = myVar.F[am] + (myVar.qs[am-1] * myVar.Ls[am-1]) / 2
    } else {
        B[1] = myVar.F[1] + (myVar.qs[0] * myVar.Ls[0]) / 2
    }
    if myVar.bbase[0] == true {
        B[0] = 0
    }
    if myVar.bbase[1] == true {
        B[am] = 0
    }
    
    return B
}

/// Добавляет столбец B к A — расширенная матрица для метода Гаусса
func getForElimination(A: [[Double]], B: [Double], myVar: MyVar) -> [[Double]] {
    var sys = A
    let am: Int = myVar.getAmount()
    
    for i in 0...am {
        sys[i].append(B[i])
    }
    return sys
}


/// Решение СЛАУ методом Гаусса; возвращает nil при вырожденной матрице
func gaussEliminate(_ sys: [[Double]]) -> [Double]? {
  var system = sys

  let size = system.count

  for i in 0..<size-1 where system[i][i] != 0 {
    for j in i..<size-1 {
      let factor = system[j + 1][i] / system[i][i]

      for k in i..<size+1 {
        system[j + 1][k] -= factor * system[i][k]
      }
    }
  }

  for i in (1..<size).reversed() where system[i][i] != 0 {
    for j in (1..<i+1).reversed() {
      let factor = system[j - 1][i] / system[i][i]

      for k in (0..<size+1).reversed() {
        system[j - 1][k] -= factor * system[i][k]
      }
    }
  }

  var solutions = [Double]()

  for i in 0..<size {
    guard system[i][i] != 0 else {
      return nil
    }

    system[i][size] /= system[i][i]
    system[i][i] = 1
    solutions.append(system[i][size])
  }

  return solutions
}


/// Продольные усилия в начале и конце стержня ind по решениям sols
func getmidlN(sols: [Double], myVar: MyVar, ind: Int) -> (N0: Double, NL: Double) {
    var N1: Double
    var N2: Double
    
    let x: Double = myVar.Ls[ind]
    N1 = (myVar.E * myVar.As[ind]) / myVar.Ls[ind] * (sols[ind+1] - sols[ind]) + (myVar.qs[ind] * myVar.Ls[ind]) / 2
    N2 = N1 - x * myVar.qs[ind]
    
    return (N1, N2)
}

/// Продольные усилия для стержня ind (решает систему и вызывает getmidlN)
func getN(myVar: MyVar, ind: Int) -> (N0: Double, NL: Double) {
    let A = createAMatr(myVar: myVar)
    let B = createBMatr(myVar: myVar)
    let sys = getForElimination(A: A, B: B, myVar: myVar)

    let sols = gaussEliminate(sys)!
    let n = getmidlN(sols: sols, myVar: myVar, ind: ind)
    
    return n
}


/// Координата и значение экстремума перемещения u на стержне ind
func solveQuadratic(sols: [Double], myVar: MyVar, ind: Int)  -> (L: Double, u: Double) {
    let a: Double = -(myVar.qs[ind] / (2*myVar.E * myVar.As[ind]))
    let b: Double = sols[ind + 1] / myVar.Ls[ind] - sols[ind] / myVar.Ls[ind] + (myVar.qs[ind] * myVar.Ls[ind]) / (2*myVar.E * myVar.As[ind])
    let c: Double = sols[ind]
    
    let x: Double = -b / (2*a)
    let y: Double = c - (pow(b, 2) / (4*a))
    return (x, y)
}



/// Перемещение u в точке x на стержне ind (квадратичная зависимость)
func quadratic(sols: [Double], myVar: MyVar, ind: Int, x: Double) -> Double {
    let a: Double = -(myVar.qs[ind] / (2*myVar.E * myVar.As[ind]))
    let b: Double = sols[ind + 1] / myVar.Ls[ind] - sols[ind] / myVar.Ls[ind] + (myVar.qs[ind] * myVar.Ls[ind]) / (2*myVar.E * myVar.As[ind])
    let c: Double = sols[ind]
    
    let y: Double = a*x*x + b*x + c
    return y
}


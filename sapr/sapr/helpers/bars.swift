// Модель данных задачи: длины L, площади A, нагрузки q/F, E, σдоп, заделки
// MyVar — наблюдаемый объект для ввода; getFromFile/getToFile — обмен с файлом; getAmount, comparativeL/A, qRight, FRight — расчётные хелперы
// getToFile, doubleToBool, change1 — глобальные хелперы для экспорта и преобразований

import Foundation
import Combine

/// Параметры конструкции: стержни (L, A, q, F), модуль E, допуск σ, заделки (base/bbase)
class MyVar: ObservableObject, Codable {
    @Published var Ls: [Double] = [2, 1, 0, 0, 0] 
    @Published var As: [Double] = [2,1,2,0,0]
    @Published var qs: [Double] = [0, 1, 0, 0, 0]
    @Published var F: [Double] = [0,-2,0,0,0,0]
    @Published var E: Double = 2e11
    @Published var stress: Double = 1.6e8
    
    
    @Published var prev: [Double] = [1, 1, 0, 0, 0]
    @Published var base: [Double] = [1, 0]
    
    @Published var text: String = "0"
    @Published var bbase: [Bool] = [true, false]
    
    init() {
        
    }
    required init(from decoder: Decoder) throws {
        
    }
    
    func encode(to encoder: Encoder) throws {
        
    }
    
    init(text: String) {
        let myVar = MyVar()
        myVar.getFromFile(text: text)
    }
    
    
    /// Разбирает строку из файла (формат «à» + числа через пробел) и заполняет все поля
    func getFromFile (text: String) {
        var array = text.components(separatedBy: " ")
        if array[0] == "à" {
            array.remove(at: 0)
            let DoubleArray = array.map {Double($0)}
            self.Ls[0] = DoubleArray[0]!
            self.Ls[1] = DoubleArray[1]!
            self.Ls[2] = DoubleArray[2]!
            self.Ls[3] = DoubleArray[3]!
            self.Ls[4] = DoubleArray[4]!
            self.As[0] = DoubleArray[5]!
            self.As[1] = DoubleArray[6]!
            self.As[2] = DoubleArray[7]!
            self.As[3] = DoubleArray[8]!
            self.As[4] = DoubleArray[9]!
            self.qs[0] = DoubleArray[10]!
            self.qs[1] = DoubleArray[11]!
            self.qs[2] = DoubleArray[12]!
            self.qs[3] = DoubleArray[13]!
            self.qs[4] = DoubleArray[14]!
            self.F[0] = DoubleArray[15]!
            self.F[1] = DoubleArray[16]!
            self.F[2] = DoubleArray[17]!
            self.F[3] = DoubleArray[18]!
            self.F[4] = DoubleArray[19]!
            self.F[5] = DoubleArray[20]!
            self.E = DoubleArray[21]!
            self.prev[0] = DoubleArray[22]!
            self.prev[1] = DoubleArray[23]!
            self.prev[2] = DoubleArray[24]!
            self.prev[3] = DoubleArray[25]!
            self.prev[4] = DoubleArray[26]!
            self.base[0] = DoubleArray[27]!
            self.base[1] = DoubleArray[28]!
            self.stress = DoubleArray[29]!
            self.text = text
            change1(bbase: &self.bbase[0], base: self.base[0])
            change1(bbase: &self.bbase[1], base: self.base[1])
        } else {
            
            
            
        }
        
    }
    /// Возвращает число активных стержней (по L > 0 и A > 0)
    func getAmount() -> Int {
        var a: Int = 1
        for i in 1...4 {
            if self.Ls[i] > 0 && self.As[i] > 0 {
                a += 1
            } else {
                return a
            }
        }
        return a
    }
    
    /// Нормированные длины стержней для отрисовки (масштаб 1–4)
    func comparativeL() -> [Double] {
        var am = self.getAmount()
        var cL = [Double](repeating: 1, count: am)
        var ls: [Double] = [Double](repeating: 1, count: am)
        am -= 1
        for i in 0...am {
            ls[i] = self.Ls[i]
        }
        
        var largest = Double(ls.max() ?? 12)
        var smallest = Double(ls.min() ?? 12)

        
        if largest / smallest <= 3 {
            for i in 0...am {
                cL[i] = ls[i] / smallest
            }
        } else {
            let indL = Int(ls.firstIndex(where: {$0 == largest}) ?? 0)
            let indS = Int(ls.firstIndex(where: {$0 == smallest}) ?? 0)
            
            cL[indL] = 4
            cL[indS] = 1
            var arr: [Double] = ls.sorted()
            
            for i in 0...am {
                if i == indL || i == indS {
                    continue
                }
                if ls[i] == largest{
                    cL[i] = 4
                } else if ls[i] == smallest {
                    cL[i] = 1
                } else {
                    if am == 2 {
                        cL[i] = 2
                    } else if am == 3 {
                        if ls[i] == arr[2] {
                            cL[i] = 3
                        } else {
                            cL[i] = 2
                            
                        }
                    } else if am == 4 {
                        if ls[i] == arr[3] {
                            cL[i] = 3.2
                        } else if ls[i] == arr[2] {
                            cL[i] = 2.4
                        } else if ls[i] == arr[1] {
                            cL[i] = 1.5
                        }
                    }
                }
            }
            
        }
        
        return cL
    }
    /// Нормированные площади для отрисовки (масштаб 1–4)
    func comparativeA() -> [Double] {
        var am = self.getAmount()
        var cA = [Double](repeating: 1, count: am)
        var As: [Double] = [Double](repeating: 1, count: am)
        am -= 1
        for i in 0...am {
            As[i] = self.As[i]
        }
        var largest = Double(As.max() ?? 12)
        var smallest = Double(As.min() ?? 12)
        if largest / smallest <= 4 {
            for i in 0...am {
                cA[i] = As[i] / smallest
            }
        } else {
            let indL = Int(As.firstIndex(where: {$0 == largest}) ?? 0)
            let indS = Int(As.firstIndex(where: {$0 == smallest}) ?? 0)
            
            cA[indL] = 4
            cA[indS] = 1
            var arr: [Double] = As.sorted()
            
            for i in 0...am {
                if i == indL || i == indS {
                    continue
                }
                if As[i] == largest{
                    cA[i] = 4
                } else if As[i] == smallest {
                    cA[i] = 1
                } else {
                    if am == 2 {
                        cA[i] = 2
                    } else if am == 3 {
                        if As[i] == arr[2] {
                            cA[i] = 3
                        } else {
                            cA[i] = 2
                            
                        }
                    } else if am == 4 {
                        if As[i] == arr[3] {
                            cA[i] = 3.2
                        } else if As[i] == arr[2] {
                            cA[i] = 2.4
                        } else if As[i] == arr[1] {
                            cA[i] = 1.5
                        }
                    }
                }
            }
            
        }
        
        return cA
    }
    
    /// Направление распределённой нагрузки q (вправо, если q > 0)
    func qRight(ind: Int) -> Bool {
        if self.qs[ind] > 0 {
            return true
        } else {
            return false
        }
    }
    /// Направление сосредоточенной силы F (вправо, если F > 0)
    func FRight(ind: Int) -> Bool {
        if self.F[ind] > 0 {
            return true
        } else {
            return false
        }
    }
}

/// Формирует строку для сохранения в файл (префикс «à» + числа через пробел)
func getToFile (myVar: MyVar) -> String {
    let array1  = myVar.Ls + myVar.As
    let array15: [Double] = [myVar.E]
    let array12: [Double] = [myVar.stress]
    let array2 =  myVar.qs + myVar.F
    let array3 = array15 + myVar.prev + myVar.base + array12
    let array  = array1 + array2 + array3
    let string = "à " + array.map{String($0)}.joined(separator: " ")
    
    return string
}



/// Преобразует [0/1, 0/1] в массив Bool (для заделок)
func doubleToBool(x: [Double]) -> [Bool] {
    var y: [Bool] = [true, true]
    if x[0] == 1 {
        y[0] = true
    } else {
        y[0] = false
    }
    if x[1] == 1 {
        y[1] = true
    } else {
        y[1] = false
    }
    return y
}

/// Синхронизирует bbase с base: base == 1 → true, иначе false
func change1(bbase: inout Bool, base: Double) {
    if base == 1 {
        bbase = true
    } else {
        bbase = false
    }
}

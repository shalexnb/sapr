// Юнит-тесты: MyVar (getAmount, qRight, FRight), getToFile/getFromFile roundtrip
// doubleToBool, change1, gaussEliminate, createAMatr/createBMatr/getForElimination и полный пайплайн расчёта

import XCTest
@testable import sapr

final class saprTests: XCTestCase {

    override func setUpWithError() throws {}

    override func tearDownWithError() throws {}

    // MARK: - MyVar.getAmount()

    func testGetAmount_oneBar() throws {
        let myVar = MyVar()
        myVar.Ls = [2, 0, 0, 0, 0]
        myVar.As = [2, 0, 0, 0, 0]
        XCTAssertEqual(myVar.getAmount(), 1)
    }

    func testGetAmount_twoBars() throws {
        let myVar = MyVar()
        myVar.Ls = [2, 1, 0, 0, 0]
        myVar.As = [2, 1, 0, 0, 0]
        XCTAssertEqual(myVar.getAmount(), 2)
    }

    func testGetAmount_threeBars() throws {
        let myVar = MyVar()
        myVar.Ls = [2, 1, 1, 0, 0]
        myVar.As = [2, 1, 2, 0, 0]
        XCTAssertEqual(myVar.getAmount(), 3)
    }

    func testGetAmount_defaultIsTwo() throws {
        let myVar = MyVar()
        XCTAssertEqual(myVar.getAmount(), 2)
    }

    // MARK: - MyVar.qRight / FRight

    func testQRight_positiveReturnsTrue() throws {
        let myVar = MyVar()
        myVar.qs[1] = 1
        XCTAssertTrue(myVar.qRight(ind: 1))
    }

    func testQRight_zeroReturnsFalse() throws {
        let myVar = MyVar()
        myVar.qs[0] = 0
        XCTAssertFalse(myVar.qRight(ind: 0))
    }

    func testFRight_positiveReturnsTrue() throws {
        let myVar = MyVar()
        myVar.F[1] = 5
        XCTAssertTrue(myVar.FRight(ind: 1))
    }

    func testFRight_negativeReturnsFalse() throws {
        let myVar = MyVar()
        myVar.F[1] = -2
        XCTAssertFalse(myVar.FRight(ind: 1))
    }

    // MARK: - getToFile / getFromFile roundtrip

    func testGetToFileStartsWithMarker() throws {
        let myVar = MyVar()
        let str = getToFile(myVar: myVar)
        XCTAssertTrue(str.hasPrefix("à "))
        XCTAssertTrue(str.contains(" "))
    }

    func testGetFromFileAndGetToFileRoundtrip() throws {
        let myVar = MyVar()
        myVar.Ls = [2, 1, 0, 0, 0]
        myVar.As = [2, 1, 2, 0, 0]
        myVar.qs = [0, 1, 0, 0, 0]
        myVar.F = [0, -2, 0, 0, 0, 0]
        myVar.E = 2e11
        myVar.stress = 1.6e8
        myVar.prev = [1, 1, 0, 0, 0]
        myVar.base = [1, 0]

        let exported = getToFile(myVar: myVar)
        let myVar2 = MyVar()
        myVar2.getFromFile(text: exported)

        XCTAssertEqual(myVar2.Ls, myVar.Ls)
        XCTAssertEqual(myVar2.As, myVar.As)
        XCTAssertEqual(myVar2.qs, myVar.qs)
        XCTAssertEqual(myVar2.F, myVar.F)
        XCTAssertEqual(myVar2.E, myVar.E)
        XCTAssertEqual(myVar2.stress, myVar.stress)
        XCTAssertEqual(myVar2.base, myVar.base)
    }

    // MARK: - doubleToBool / change1

    func testDoubleToBool() throws {
        XCTAssertEqual(doubleToBool(x: [1, 1]), [true, true])
        XCTAssertEqual(doubleToBool(x: [0, 0]), [false, false])
        XCTAssertEqual(doubleToBool(x: [1, 0]), [true, false])
        XCTAssertEqual(doubleToBool(x: [0, 1]), [false, true])
    }

    func testChange1() throws {
        var b: Bool = true
        change1(bbase: &b, base: 0)
        XCTAssertFalse(b)
        change1(bbase: &b, base: 1)
        XCTAssertTrue(b)
    }

    // MARK: - gaussEliminate

    func testGaussEliminate_simple2x2() throws {
        // x = 1, y = 2
        let sys = [
            [1.0, 0.0, 1.0],
            [0.0, 1.0, 2.0]
        ]
        let sols = gaussEliminate(sys)
        XCTAssertNotNil(sols)
        XCTAssertEqual(sols!.count, 2)
        XCTAssertEqual(sols![0], 1.0, accuracy: 1e-10)
        XCTAssertEqual(sols![1], 2.0, accuracy: 1e-10)
    }

    func testGaussEliminate_smallSystem() throws {
        // 2x + 0y = 4, 0x + 3y = 9  => x=2, y=3
        let sys = [
            [2.0, 0.0, 4.0],
            [0.0, 3.0, 9.0]
        ]
        let sols = gaussEliminate(sys)
        XCTAssertNotNil(sols)
        XCTAssertEqual(sols![0], 2.0, accuracy: 1e-10)
        XCTAssertEqual(sols![1], 3.0, accuracy: 1e-10)
    }

    func testGaussEliminate_singularReturnsNil() throws {
        let sys = [
            [0.0, 0.0, 1.0],
            [0.0, 0.0, 1.0]
        ]
        let sols = gaussEliminate(sys)
        XCTAssertNil(sols)
    }

    // MARK: - createAMatr / createBMatr / getForElimination

    func testCreateAMatr_oneBar_hasCorrectSize() throws {
        let myVar = MyVar()
        myVar.Ls = [1, 0, 0, 0, 0]
        myVar.As = [1, 0, 0, 0, 0]
        myVar.bbase = [true, true]
        let A = createAMatr(myVar: myVar)
        XCTAssertEqual(A.count, 2)
        XCTAssertEqual(A[0].count, 2)
    }

    func testCreateBMatr_oneBar_hasCorrectSize() throws {
        let myVar = MyVar()
        myVar.Ls = [1, 0, 0, 0, 0]
        myVar.As = [1, 0, 0, 0, 0]
        let B = createBMatr(myVar: myVar)
        XCTAssertEqual(B.count, myVar.getAmount() + 1)
    }

    func testGetForElimination_appendsB() throws {
        let myVar = MyVar()
        myVar.Ls = [1, 0, 0, 0, 0]
        myVar.As = [1, 0, 0, 0, 0]
        let A = createAMatr(myVar: myVar)
        let B = createBMatr(myVar: myVar)
        let sys = getForElimination(A: A, B: B, myVar: myVar)
        XCTAssertEqual(sys.count, A.count)
        for i in 0..<sys.count {
            XCTAssertEqual(sys[i].count, A[i].count + 1)
            XCTAssertEqual(sys[i].last, B[i])
        }
    }

    func testFullSolvePipeline_oneBar_noCrash() throws {
        let myVar = MyVar()
        myVar.Ls = [1, 0, 0, 0, 0]
        myVar.As = [1, 0, 0, 0, 0]
        myVar.bbase = [true, true]
        myVar.F = [0, 0, 0, 0, 0, 0]
        myVar.qs = [0, 0, 0, 0, 0]
        let A = createAMatr(myVar: myVar)
        let B = createBMatr(myVar: myVar)
        let sys = getForElimination(A: A, B: B, myVar: myVar)
        let sols = gaussEliminate(sys)
        XCTAssertNotNil(sols)
    }

    // MARK: - Performance (optional)

    func testPerformanceGetToFile() throws {
        let myVar = MyVar()
        measure {
            for _ in 0..<100 {
                _ = getToFile(myVar: myVar)
            }
        }
    }
}

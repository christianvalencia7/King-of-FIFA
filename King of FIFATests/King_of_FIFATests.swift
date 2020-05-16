//
//  King_of_FIFATests.swift
//  King of FIFATests
//
//  Created by Christian Valencia on 5/13/20.
//  Copyright © 2020 Christian Valencia. All rights reserved.
//

import XCTest
@testable import King_of_FIFA

class King_of_FIFATests: XCTestCase {
    var liga = Liga()
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        liga.numJugadores = 4
        let jugador1 = Jugador()
        let jugador2 = Jugador()
        let jugador3 = Jugador()
        let jugador4 = Jugador()
        
        jugador1.nombre = "A"
        jugador2.nombre = "B"
        jugador3.nombre = "C"
        jugador4.nombre = "D"
        
        liga.jugadores.append(jugador1)
        liga.jugadores.append(jugador2)
        liga.jugadores.append(jugador3)
        liga.jugadores.append(jugador4)
        
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLiga() throws {
        liga.crearAllPartidos()
        
        while liga.allPartidos.count > 0 {
            liga.crearPartidos()
            liga.printPartidos()
        }
    
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}

//
//  Partido.swift
//  King of FIFA
//
//  Created by Christian Valencia on 3/26/20.
//  Copyright © 2020 Christian Valencia. All rights reserved.
//

import Foundation
//aaaaaa
class Partido: NSObject{
    var jugador1: Jugador
    var jugador2: Jugador
    var goles1: Int = 0
    var goles2: Int = 0
    
    init(j1: Jugador, j2: Jugador)
    {
        jugador1 = j1
        jugador2 = j2
    }
    
    public func getGanador() -> Jugador
    {
        if goles1 > goles2 {return jugador1}
        return jugador2
    }
    
    public func getPerdedor() -> Jugador
    {
        if goles1 > goles2 {return jugador2}
        return jugador1
    }
    
    public func toString() -> String{
        return "\(jugador1.nombre) vs \(jugador2.nombre)"
    }
}

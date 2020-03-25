//
//  Jugador.swift
//  King of FIFA
//
//  Created by Christian Valencia on 3/22/20.
//  Copyright © 2020 Christian Valencia. All rights reserved.
//

import Foundation

class Jugador{
    var nombre: String
    var userID: String
    var equipo: String
    
    init(n: String, u: String, e: String)
    {
        nombre = n
        userID = u
        equipo = e
    }
    
    public func toString() -> String
    {
        return "Nombre: \(nombre), UserID: \(userID), Equipo: \(equipo)\n"
    }
}

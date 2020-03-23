//
//  Torneo.swift
//  King of FIFA
//
//  Created by Christian Valencia on 3/22/20.
//  Copyright © 2020 Christian Valencia. All rights reserved.
//

import Foundation

class Torneo {
    private var numJugadores: Int
    private var jugardores = [Jugador]()
    private var online: Bool
    private var idaYVuelta: Bool
    private var nombre: String
    
    init(n: Int){
        numJugadores = n
        online = true
        idaYVuelta = true
        nombre = "Defalt"
    }
    init(){
        numJugadores = -1
        online = true
        idaYVuelta = true
        nombre = "Defalt"
    }
    
    public func setNum(num: Int)
    {
        numJugadores = num
    }
    
    public func getNum() -> Int
    {
        return numJugadores
    }
    
    public func getIdaYVuelta() -> Bool
    {
        return idaYVuelta
    }
    
    public func setIdaYVuelta(b: Bool)
    {
        idaYVuelta = b
    }
    
    public func getOnline() -> Bool
    {
        return online
    }
    
    public func setOnline(b: Bool)
    {
        online = b
    }
}

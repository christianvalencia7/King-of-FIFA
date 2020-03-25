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
    private var jugadores = [Jugador]()
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
    
    public func addJugador(jugador: Jugador)
    {
        jugadores.append(jugador)
    }
    
    public func printTorneo()
    {
        print("Torneo: \(nombre)\n")
        print("Num Jugadores: \(numJugadores)\n")
        print("Online: \(online)\n")
        print("Ida Y Vuelta: \(idaYVuelta)\n")
        print("Torneo: \(nombre)\n")
        print("Torneo: \(nombre)\n")
        print("Jugadores: \(jugadores.count)\n")
        for x in 0...numJugadores-1{
            print("\(jugadores[x].toString())")
        }
    }
}

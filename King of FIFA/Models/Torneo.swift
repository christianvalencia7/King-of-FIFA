//
//  Torneo.swift
//  King of FIFA
//
//  Created by Christian Valencia on 3/22/20.
//  Copyright © 2020 Christian Valencia. All rights reserved.
//

import Foundation
import os.log

class Torneo: NSObject, NSCoding {
    var id = UUID()
    var numJugadores: Int
    var jugadores = [Jugador]()
    var partidos = [Partido]()
    var online: Bool
    var idaYVuelta: Bool
    var nombre: String
    
    //MARK: Archiving Paths
     
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("torneos")
    
    //MARK: Types
    struct PropertyKey {
        static let id = "id"
        static let numJugadores = "numJugadores"
        static let jugadores = "jugadores"
        static let partidos = "partidos"
        static let online = "online"
        static let idaYVuelta = "idaYVuelta"
        static let nombre = "nombre"
    }
    
    init(n: Int){
        numJugadores = n
        online = true
        idaYVuelta = true
        nombre = "Defalt"
    }
    init(id: UUID, n: Int, j:[Jugador], p:[Partido], o:Bool, i: Bool, nom: String){
        numJugadores = n
        online = o
        idaYVuelta = i
        nombre = nom
        jugadores = j
        partidos = p
        self.id = id
    }
    override init(){
        numJugadores = -1
        online = true
        idaYVuelta = true
        nombre = "Defalt"
    }
    
    public func crearPartidos()
    {
        while(jugadores.count >= 2)
        {
            var rand = Int.random(in: 0 ..< jugadores.count)
            let jugador1 = jugadores[rand];
            jugadores.remove(at: rand)
            rand = Int.random(in: 0 ..< jugadores.count)
            let jugador2 = jugadores[rand];
            jugadores.remove(at: rand)
            let partido = Partido(j1: jugador1, j2: jugador2)
            partidos.append(partido)
        }
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
    
    public func setNombre(s: String)
    {
        nombre = s
    }
    
    public func getNombre() -> String
    {
        return nombre
    }
    
    public func addJugador(jugador: Jugador)
    {
        jugadores.append(jugador)
    }
    public func printPartidos()
    {
        for x in 0..<partidos.count{
            print("\(partidos[x].toString())\n")
        }
    }
    public func printTorneo()
    {
        print("Torneo: \(nombre)\n")
        print("Num Jugadores: \(numJugadores)\n")
        print("Online: \(online)\n")
        print("Ida Y Vuelta: \(idaYVuelta)\n")
        print("Jugadores:\n")
        for x in 0...numJugadores-1{
            print("\(jugadores[x].toString())")
        }
    }
    
    //MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: PropertyKey.id)
        aCoder.encode(numJugadores, forKey: PropertyKey.numJugadores)
        aCoder.encode(jugadores, forKey: PropertyKey.jugadores)
        aCoder.encode(partidos, forKey: PropertyKey.partidos)
        aCoder.encode(online, forKey: PropertyKey.online)
        aCoder.encode(idaYVuelta, forKey: PropertyKey.idaYVuelta)
        aCoder.encode(nombre, forKey: PropertyKey.nombre)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let id = aDecoder.decodeObject(forKey: PropertyKey.id) as? UUID else {
            os_log("Unable to decode the Torneo.", log: OSLog.default, type: .debug)
            return nil
        }
        let numJugadores = (aDecoder.decodeObject(forKey: PropertyKey.numJugadores) as? Int)!
        let jugadores = (aDecoder.decodeObject(forKey: PropertyKey.jugadores) as? [Jugador])!
        let partidos = (aDecoder.decodeObject(forKey: PropertyKey.partidos) as? [Partido])!
        let online = (aDecoder.decodeObject(forKey: PropertyKey.online) as? Bool)!
        let idaYVuelta = (aDecoder.decodeObject(forKey: PropertyKey.idaYVuelta) as? Bool)!
        let nombre = (aDecoder.decodeObject(forKey: PropertyKey.nombre) as? String)!
        
        self.init(id: id, n: numJugadores, j:jugadores, p:partidos, o:online, i: idaYVuelta, nom: nombre)
    }
    
}

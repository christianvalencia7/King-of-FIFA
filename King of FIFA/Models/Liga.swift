//
//  Liga.swift
//  King of FIFA
//
//  Created by Christian Valencia on 5/13/20.
//  Copyright © 2020 Christian Valencia. All rights reserved.
//

import Foundation

import Foundation
import os.log

class Liga: NSObject, NSCoding{
    var id = UUID()
    var numJugadores: Int
    var jugadores = [Jugador]()
    var partidos = [Partido]()
    var online: Bool
    var idaYVuelta: Bool
    var nombre: String
    var allPartidos = [Partido]()
    var resultados = [Partido]()
    var fechas = 1
    
    //MARK: Archiving Paths
     
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("ligas")
    
    //MARK: Types
    struct PropertyKey {
        static let id = "id"
        static let numJugadores = "numJugadores"
        static let jugadores = "jugadores"
        static let partidos = "partidos"
        static let online = "online"
        static let idaYVuelta = "idaYVuelta"
        static let nombre = "nombre"
        static let allPartidos = "allPartidos"
        static let resultados = "resultados"
        static let fechas = "fechas"
    }

    init(n: Int){
        numJugadores = n
        online = false
        idaYVuelta = false
        nombre = "Default"
        super.init()
    }
    init(id: UUID, n: Int, j:[Jugador], p:[Partido], o:Bool, i: Bool, nom: String, a:[Partido], r:[Partido], f: Int){
        numJugadores = n
        online = o
        idaYVuelta = i
        nombre = nom
        jugadores = j
        partidos = p
        resultados = r
        allPartidos = a
        fechas = f
        self.id = id
        super.init()
    }
    override init(){
        numJugadores = -1
        online = false
        idaYVuelta = false
        nombre = "Defalt"
        super.init()
    }

    
    
    public func crearAllPartidos()
    {
        jugadores.shuffle()
        if numJugadores % 2 == 1 {
            numJugadores = numJugadores + 1
            let jugadorBye = Jugador()
            jugadorBye.nombre = "BYE"
            jugadores.append(jugadorBye)
        }
        
        let mid = numJugadores / 2
            let fechasTotal = numJugadores - 1
            // Split list into two

            var l1 = [Jugador]();
        
            for i in 0 ..< mid {
                let temp = jugadores[i]
                l1.append(temp)
            }

            var l2 = [Jugador]();
            // We need to reverse the other list
           
            for i in stride(from: numJugadores - 1, through: mid, by: -1){
                let temp = jugadores[i]
                l2.append(temp)
            }
            
            var count = 0
            while count < fechasTotal{
                //Create partidos
                for i in 0..<mid
                {
                    let p = Partido()
                    p.jugador1 = l1[i]
                    p.jugador2 = l2[i]
                    allPartidos.append(p)
                }
                
                //Move jugadores around
                l2.append(l1[mid-1])
                l1.insert(l2[0], at: 1)
                l2.remove(at: 0)
                count = count + 1
            }
        
    }
    
    public func getFecha() -> Int{
        let partidosPorFecha = numJugadores / 2
        return resultados.count / partidosPorFecha + 1
    }

    public func crearPartidos() -> Bool
    {
        
            for p in partidos {
                resultados.append(p)
            }
            partidos.removeAll()
        if allPartidos.count > 0 {
            var jugando = [Jugador]()
            var i = 0
            while jugando.count < numJugadores
            {
                let partido = allPartidos[i]
                if !jugando.contains(partido.jugador1) && !jugando.contains(partido.jugador2){
                    jugando.append(partido.jugador1)
                    jugando.append(partido.jugador2)
                    partidos.append(partido)
                    allPartidos.remove(at: i)
                    
                } else {
                    i = i + 1
                }
            }
            fechas = fechas + 1
            return true
        }
        return false
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
        if jugadores.count > 0{
            for x in 0...jugadores.count - 1{
                print("\(jugadores[x].toString())")
            }
        }
        print("Partidos: \(partidos.count)\n")
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
        aCoder.encode(allPartidos, forKey: PropertyKey.allPartidos)
        aCoder.encode(resultados, forKey: PropertyKey.resultados)
        aCoder.encode(fechas, forKey: PropertyKey.fechas)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let id = aDecoder.decodeObject(forKey: PropertyKey.id) as? UUID else {
            os_log("Unable to decode the torneo id.", log: OSLog.default, type: .debug)
            return nil
        }
        guard let jugadores = aDecoder.decodeObject(forKey: PropertyKey.jugadores) as? [Jugador] else {
            os_log("Unable to decode the jugadores.", log: OSLog.default, type: .debug)
            return nil
        }
        guard let partidos = aDecoder.decodeObject(forKey: PropertyKey.partidos) as? [Partido] else {
            os_log("Unable to decode the partidos.", log: OSLog.default, type: .debug)
            return nil
        }
        guard let nombre = aDecoder.decodeObject(forKey: PropertyKey.nombre) as? String else {
            os_log("Unable to decode the Torneo nombre.", log: OSLog.default, type: .debug)
            return nil
        }
        guard let allPartidos = aDecoder.decodeObject(forKey: PropertyKey.allPartidos) as? [Partido] else {
            os_log("Unable to decode the allPartidos.", log: OSLog.default, type: .debug)
            return nil
        }
        guard let resultados = aDecoder.decodeObject(forKey: PropertyKey.resultados) as? [Partido] else {
            os_log("Unable to decode the resultados.", log: OSLog.default, type: .debug)
            return nil
        }
        
        let fechas = aDecoder.decodeInteger(forKey: PropertyKey.fechas)
        
        let numJugadores = aDecoder.decodeInteger(forKey: PropertyKey.numJugadores)
        let online = aDecoder.decodeBool(forKey: PropertyKey.online)
        let idaYVuelta = aDecoder.decodeBool(forKey: PropertyKey.idaYVuelta)
        
        self.init(id: id, n: numJugadores, j:jugadores, p:partidos, o:online, i: idaYVuelta, nom: nombre, a:allPartidos, r:resultados, f: fechas)
    }
    
}

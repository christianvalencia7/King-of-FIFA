//
//  Partido.swift
//  King of FIFA
//
//  Created by Christian Valencia on 3/26/20.
//  Copyright © 2020 Christian Valencia. All rights reserved.
//

import Foundation
import os.log


class Partido: NSObject, NSCoding{
    var id = UUID()
    var jugador1: Jugador
    var jugador2: Jugador
    var goles1: Int = 0
    var goles2: Int = 0
    
    //MARK: Types
    struct PropertyKey {
        static let id = "id"
        static let jugador1 = "jugador1"
        static let jugador2 = "jugador2"
        static let goles1 = "goles1"
        static let goles2 = "goles2"
    }
    init(j1: Jugador, j2: Jugador, g1: Int, g2: Int, i: UUID)
    {
        jugador1 = j1
        jugador2 = j2
        goles1 = g1
        goles2 = g2
        id = i
    }
    
    init(j1: Jugador, j2: Jugador, g1: Int, g2: Int)
    {
        jugador1 = j1
        jugador2 = j2
        goles1 = g1
        goles2 = g2
    }
    
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
    
    //MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(jugador1, forKey: PropertyKey.jugador1)
        aCoder.encode(jugador2, forKey: PropertyKey.jugador2)
        aCoder.encode(goles1, forKey: PropertyKey.goles1)
        aCoder.encode(goles2, forKey: PropertyKey.goles2)
        aCoder.encode(id, forKey: PropertyKey.id)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let id = aDecoder.decodeObject(forKey: PropertyKey.id) as? UUID else {
            os_log("Unable to decode the partido id.", log: OSLog.default, type: .debug)
            return nil
        }
        guard let jugador1 = aDecoder.decodeObject(forKey: PropertyKey.jugador1) as? Jugador else {
            os_log("Unable to decode the jugador1.", log: OSLog.default, type: .debug)
            return nil
        }
        guard let jugador2 = aDecoder.decodeObject(forKey: PropertyKey.jugador2) as? Jugador else {
            os_log("Unable to decode the jugador2.", log: OSLog.default, type: .debug)
            return nil
        }
        
        let goles1 = aDecoder.decodeInteger(forKey: PropertyKey.goles1)
        let goles2 = aDecoder.decodeInteger(forKey: PropertyKey.goles2)
        
        self.init(j1: jugador1, j2: jugador2, g1: goles1, g2: goles2, i: id)
    }
}

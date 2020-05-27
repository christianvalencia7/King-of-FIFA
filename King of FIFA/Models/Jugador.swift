//
//  Jugador.swift
//  King of FIFA
//
//  Created by Christian Valencia on 3/22/20.
//  Copyright © 2020 Christian Valencia. All rights reserved.
//

import Foundation
import os.log

class Jugador: NSObject, NSCoding, Codable{
    var nombre: String
    var userID: String
    var equipo: String
    
    override init()
    {
        nombre = ""
        userID = ""
        equipo = ""
    }
    
    init(n: String, u: String, e: String)
    {
        nombre = n
        userID = u
        equipo = e
    }
    
    enum CodingKeys: String, CodingKey {
        case nombre
        case userID
        case equipo
    }
    
    //MARK: Types
    struct PropertyKey {
        static let userID = "userID"
        static let equipo = "equipo"
        static let nombre = "nombre"
    }
    public func toString() -> String
    {
        return "Nombre: \(nombre), UserID: \(userID), Equipo: \(equipo)\n"
    }
    
    //MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(nombre, forKey: PropertyKey.nombre)
        aCoder.encode(userID, forKey: PropertyKey.userID)
        aCoder.encode(equipo, forKey: PropertyKey.equipo)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let nombre = aDecoder.decodeObject(forKey: PropertyKey.nombre) as? String else {
            os_log("Unable to decode nombre jugador", log: OSLog.default, type: .debug)
            return nil
        }
        guard let userID = aDecoder.decodeObject(forKey: PropertyKey.userID) as? String else {
            os_log("Unable to decode userID", log: OSLog.default, type: .debug)
            return nil
        }
        guard let equipo = aDecoder.decodeObject(forKey: PropertyKey.equipo) as? String else {
            os_log("Unable to decode equipo", log: OSLog.default, type: .debug)
            return nil
        }
        
        self.init(n: nombre, u: userID, e: equipo)
    }
}

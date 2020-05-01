//
//  TorneoCreadoViewController.swift
//  King of FIFA
//
//  Created by Christian Valencia on 3/25/20.
//  Copyright © 2020 Christian Valencia. All rights reserved.
//

import UIKit

class TorneoCreadoViewController: UIViewController {

    @IBOutlet weak var nombreTorneo: UITextField!
    @IBOutlet weak var numJugadores: UITextField!
    @IBOutlet weak var online: UITextField!
    @IBOutlet weak var idaYVuelta: UITextField!
    
    var torneo = Torneo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nombreTorneo.text = torneo.getNombre()
        numJugadores.text = "Torneo de \(torneo.getNum()) jugadores"
        online.text = torneo.getOnline() ? "Online" : "Offline"
        idaYVuelta.text = torneo.getIdaYVuelta() ? "Modo: ida y vuelta" : "Modo: único partido"
        saveTorneo(torneo: torneo)
    }
    
    
    @IBAction func goBack(_ sender: Any) {
        
    }
    
   
       
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    //FILE MANAGMENT
    private func saveTorneo(torneo: Torneo) {

        if(!saveObject(fileName: "\(torneo.id)", object: torneo))
        {
                print("TORNEO NOT SAVED")
        }
    }
    
    func saveObject(fileName: String, object: Any) -> Bool {
        do{
            if !FileManager.default.fileExists(atPath: getDirectoryPath().appendingPathComponent("torneos", isDirectory: true).path) {
                try FileManager.default.createDirectory(at: self.getDirectoryPath().appendingPathComponent("torneos", isDirectory: true), withIntermediateDirectories: true, attributes: nil)
                print("\(try FileManager.default.contentsOfDirectory(atPath: self.getDirectoryPath().path))")
            }
        }
        catch{print("CATCH")}
        let f = self.getDirectoryPath().appendingPathComponent("torneos", isDirectory: true)
        let filePath = f.appendingPathComponent(fileName)//1
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: object, requiringSecureCoding: false)//2
            try data.write(to: filePath)//3
            return true
        } catch {
            print("2error is: \(error.localizedDescription)")//4
        }
        return false
    }
    
    
    func getDirectoryPath() -> URL {
           let arrayPaths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
           return arrayPaths[0]
       }

}

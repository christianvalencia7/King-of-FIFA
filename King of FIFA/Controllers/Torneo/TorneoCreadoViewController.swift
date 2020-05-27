//
//  TorneoCreadoViewController.swift
//  King of FIFA
//
//  Created by Christian Valencia on 3/25/20.
//  Copyright © 2020 Christian Valencia. All rights reserved.
//

import UIKit
import Firebase

class TorneoCreadoViewController: UIViewController {

    @IBOutlet weak var nombreTorneo: UITextField!
    @IBOutlet weak var numJugadores: UITextField!
    @IBOutlet weak var online: UITextField!
    @IBOutlet weak var idaYVuelta: UITextField!
    
    var torneo = Torneo()
    var liga = Liga()
    var isLiga = false
    var isOnline: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nombreTorneo.text = isLiga ? liga.nombre : torneo.getNombre()
        numJugadores.text = isLiga ? "Liga de \(liga.numJugadores) jugadores" : "Torneo de \(torneo.getNum()) jugadores"
        if isLiga{
            online.text = liga.online ? "Online" : "Offline"
            idaYVuelta.text = liga.idaYVuelta ? "Modo: ida y vuelta" : "Modo: único partido"
        }
        else{
            online.text = torneo.getOnline() ? "Online" : "Offline"
            idaYVuelta.text = torneo.getIdaYVuelta() ? "Modo: ida y vuelta" : "Modo: único partido"
        }
        
        
        
    }
    
    @IBAction func doneClicked(_ sender: Any) {
        //Liga
        if isLiga {
            liga.crearAllPartidos()
            if !liga.crearPartidos(){
                print("Error creating partidos")
            }
            //Local
            if !isOnline {
                saveLiga(liga: liga)
                performSegue(withIdentifier: "toLigas", sender: nil)
            }
                
            //Online
            else{
                
            }
            
        }
            
        //Torneo
        else {
            
            //Local
            if !isOnline {
                saveTorneo(torneo: torneo)
                performSegue(withIdentifier: "toTorneos", sender: nil)
            }
            
            //Online
            else {
                uploadTorneo(torneo: torneo)
                print("SUCCESS")
            }
            
        }
    }
    
   
       
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    
    //MARK: - ONLINE DATABASE MANAGMENT
    private func uploadTorneo(torneo: Torneo) {
        let firestoreDatabase = Firestore.firestore()
        do {
            let jsonData = try JSONEncoder().encode(torneo)
            let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
            let firestoreTorneo = [torneo.nombre : jsonObject] as [String : Any]

            firestoreDatabase.collection(torneo.creadoPor).document("Competencias").collection("Torneos").document(torneo.id.uuidString).setData(firestoreTorneo)
        }
        catch {
            print("ERROR!!! \(error.localizedDescription)")
        }
        
        
        
        
    }
    
    private func upLoadLiga(liga: Liga) {
        
    }
    
    
    //MARK: - FILE MANAGMENT
    private func saveTorneo(torneo: Torneo) {

        if(!saveObject(fileName: "\(torneo.id)", object: torneo))
        {
                print("TORNEO NOT SAVED")
        }
    }
    
    private func saveLiga(liga: Liga) {

        if(!saveObject(fileName: "\(liga.id)", object: liga))
        {
                print("LIGA NOT SAVED")
        }
    }
    
    func saveObject(fileName: String, object: Any) -> Bool {
        do{
            if !FileManager.default.fileExists(atPath: getDirectoryPath().appendingPathComponent(isLiga ? "ligas":"torneos", isDirectory: true).path) {
                try FileManager.default.createDirectory(at: self.getDirectoryPath().appendingPathComponent(isLiga ? "ligas":"torneos", isDirectory: true), withIntermediateDirectories: true, attributes: nil)
                print("\(try FileManager.default.contentsOfDirectory(atPath: self.getDirectoryPath().path))")
            }
        }
        catch{print("CATCH")}
        let f = self.getDirectoryPath().appendingPathComponent(isLiga ? "ligas":"torneos", isDirectory: true)
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
    
    
    
    func makeAlert(titleInput: String, messageInput: String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }

}

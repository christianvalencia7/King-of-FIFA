//
//  MarcadorViewController.swift
//  King of FIFA
//
//  Created by Christian Valencia on 4/2/20.
//  Copyright © 2020 Christian Valencia. All rights reserved.
//

import UIKit
import Firebase

class MarcadorViewController: UIViewController, UITextFieldDelegate {
    
    var selectedTorneo = 0
    var selectedPartido = 0
    var isLiga = false
    var isOnline = false
    var torneo = Torneo()
    var liga = Liga()
    var partido = Partido()
    
    @IBOutlet weak var jugador1: UITextField!
    @IBOutlet weak var jugador2: UITextField!
    @IBOutlet weak var marcador1: UITextField!
    @IBOutlet weak var marcador2: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        partido = isLiga ? liga.partidos[selectedPartido] : torneo.partidos[selectedPartido]
        jugador1.text = partido.jugador1.nombre
        jugador2.text = partido.jugador2.nombre
        marcador1.delegate = self
        marcador2.delegate = self
        marcador1.text = "\(isLiga ? liga.partidos[selectedPartido].goles1 : torneo.partidos[selectedPartido].goles1)"
        marcador2.text = "\(isLiga ? liga.partidos[selectedPartido].goles2 : torneo.partidos[selectedPartido].goles2)"
       
    }
    
    @IBAction func guardarMarcador(_ sender: UIButton) {
        
        if marcador1.text == marcador2.text && !isLiga {
            let alertController = UIAlertController(title: "Draws are not allowed", message: "In case of a draw, play another match", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alertController, animated: true, completion: nil)
        }
        else
        {
            partido.goles1 = Int(marcador1.text ?? "1") ?? 1
            partido.goles2 = Int(marcador2.text ?? "0") ?? 0
            if !isOnline {
                isLiga ? saveLiga(liga: liga) : saveTorneo(torneo: torneo)
                isLiga ? performSegue(withIdentifier: "toFechas", sender: nil) : performSegue(withIdentifier: "toFases", sender: nil)
            }
            else {
                isLiga ? saveLiga(liga: liga) : uploadTorneo(torneo: torneo)
                isLiga ? performSegue(withIdentifier: "toFechasOnline", sender: nil) : performSegue(withIdentifier: "toFasesOnline", sender: nil)
            }
            
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let viewController = segue.destination as? FaseTorneoTableViewController {
            viewController.torneo = torneo
            viewController.selectedTorneo = selectedTorneo
            viewController.selectedPartido = selectedPartido
        }
        
        if let viewController = segue.destination as? FechasTableViewController {
            viewController.liga = liga
        }
    }
    
    
    //FILE MANAGMENT
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
        
    

}

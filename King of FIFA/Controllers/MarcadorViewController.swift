//
//  MarcadorViewController.swift
//  King of FIFA
//
//  Created by Christian Valencia on 4/2/20.
//  Copyright © 2020 Christian Valencia. All rights reserved.
//

import UIKit

class MarcadorViewController: UIViewController, UITextFieldDelegate {
    
    var selectedTorneo = 0
    var selectedPartido = 0
    var torneo = Torneo()
    var partido = Partido()
    
    @IBOutlet weak var jugador1: UITextField!
    @IBOutlet weak var jugador2: UITextField!
    @IBOutlet weak var marcador1: UITextField!
    @IBOutlet weak var marcador2: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        partido = torneo.partidos[selectedPartido]
        jugador1.text = partido.jugador1.nombre
        jugador2.text = partido.jugador2.nombre
        marcador1.delegate = self
        marcador2.delegate = self
       
    }
    
    @IBAction func guardarMarcador(_ sender: UIButton) {
        
        if marcador1.text == marcador2.text {
            let alertController = UIAlertController(title: "No puede haber empate", message: "En caso de empate jugar tiempos extra, penales u otro partido de desempate", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alertController, animated: true, completion: nil)
        }
        else
        {
            partido.goles1 = Int(marcador1.text ?? "1") ?? 1
            partido.goles2 = Int(marcador1.text ?? "0") ?? 0
            saveTorneo(torneo: torneo)
            
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    private func saveTorneo(torneo: Torneo) {

        if(!saveObject(fileName: "torneo_\(torneo.id)", object: torneo))
        {
                print("TORNEO NOT SAVED")
        }
    }
    
    func saveObject(fileName: String, object: Any) -> Bool {
        
        let f = self.getDirectoryPath().appendingPathComponent("Torneos", isDirectory: true)
        let filePath = f.appendingPathComponent(fileName)//1
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: object, requiringSecureCoding: false)//2
            try data.write(to: filePath)//3
            return true
        } catch {
            print("error is: \(error.localizedDescription)")//4
        }
        return false
    }
    
    private func loadTorneos() -> [Torneo]?  {
        if let torneos = getObject(fileName: "torneos") as? [Torneo]{
            return torneos
        }
        else{
            print("TORNEO NOT LOADED")
            return nil
        }
    }
    
    func getObject(fileName: String) -> Any? {
        
        let filePath = self.getDirectoryPath().appendingPathComponent(fileName)//5
        do {
            let data = try Data(contentsOf: filePath)//6
            let object = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data)//7
            return object//8
        } catch {
            print("error is: \(error.localizedDescription)")//9
        }
        return nil
    }
    
    func getDirectoryPath() -> URL {
        let arrayPaths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return arrayPaths[0]
    }

}

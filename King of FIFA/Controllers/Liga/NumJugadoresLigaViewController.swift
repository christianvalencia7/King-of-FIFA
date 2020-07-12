//
//  NumJugadoresLigaViewController.swift
//  King of FIFA
//
//  Created by Christian Valencia on 5/15/20.
//  Copyright © 2020 Christian Valencia. All rights reserved.
//

import UIKit

class NumJugadoresLigaViewController: UIViewController, UITextFieldDelegate {

    var liga = Liga()
    var online = false
    var email = ""
    @IBOutlet weak var numJugadoresText: FormTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numJugadoresText.delegate = self

        // Do any additional setup after loading the view.
    }
    
    @IBAction func nextClicked(_ sender: UIButton) {
        let num = Int(numJugadoresText.text ?? "0") ?? 0
        
        if num < 2 || num > 200 || num % 2 == 1 {
            makeAlert(titleInput: "Error", messageInput: "El número de jugadores debe ser par y menor o igual a 200")
        }
        else {
            liga.numJugadores = num
            liga.online = online
            liga.creadoPor = email
            liga.dateCreated = Date()
            performSegue(withIdentifier: "toOpciones", sender: nil)
        }
         
        
    }
    
    func makeAlert(titleInput:String, messageInput:String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
                    let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                    alert.addAction(okButton)
                    self.present(alert, animated: true, completion: nil)
    }

    // MARK: - Navigation

   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? OpcionesTorneoViewController{
            viewController.liga = liga
            viewController.isLiga = true
            viewController.online = online
        }
    }

    
    //TEXT FIELD DELEGATION
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

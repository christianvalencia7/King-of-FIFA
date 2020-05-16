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
    @IBOutlet weak var numJugadoresText: FormTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numJugadoresText.delegate = self

        // Do any additional setup after loading the view.
    }
    


    // MARK: - Navigation

   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? OpcionesTorneoViewController{
            liga.numJugadores = Int(numJugadoresText.text ?? "0") ?? 1
            viewController.liga = liga
            viewController.isLiga = true
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

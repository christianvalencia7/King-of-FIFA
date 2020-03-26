//
//  OpcionesTorneoViewController.swift
//  King of FIFA
//
//  Created by Christian Valencia on 3/23/20.
//  Copyright © 2020 Christian Valencia. All rights reserved.
//

import UIKit

class OpcionesTorneoViewController: UIViewController,UITextFieldDelegate {
    var torneo = Torneo()
    
    @IBOutlet weak var nombre: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nombre.delegate = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func selecIdaYVuelta(_ sender: UISegmentedControl) {
        if(sender.selectedSegmentIndex == 0)
        {
            torneo.setIdaYVuelta(b: true)
        }
        else
        {
            torneo.setIdaYVuelta(b: false)
           
        }
    }
    
    @IBAction func selecOnline(_ sender: UISegmentedControl) {
        if(sender.selectedSegmentIndex == 0)
        {
            torneo.setOnline(b: true)
        }
        else
        {
            torneo.setOnline(b: false)
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
        if let viewController = segue.destination as? DatosJugadorViewController{
            torneo.setNombre(s: nombre.text ?? "default")
            viewController.torneo = torneo
        }
    }

}


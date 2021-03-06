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
    var liga = Liga()
    var isLiga = false
    var online: Bool = false
    
    @IBOutlet weak var nombre: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nombre.delegate = self
        if(isLiga){
            nombre.placeholder = "Nombre Liga"
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func selecIdaYVuelta(_ sender: UISegmentedControl) {
        if(sender.selectedSegmentIndex == 1)
        {
            torneo.setIdaYVuelta(b: true)
            liga.idaYVuelta = true
        }
        else
        {
            torneo.setIdaYVuelta(b: false)
            liga.idaYVuelta = false
           
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
    
    @IBAction func cancelClicked(_ sender: Any) {
        if(isLiga)
        {
            performSegue(withIdentifier: "toLigas", sender: nil)
        }
        else{
            performSegue(withIdentifier: "toTorneo", sender: nil)
        }
    }
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? DatosJugadorViewController{
            if isLiga {
                liga.nombre = nombre.text ?? "default"
                viewController.liga = liga
                viewController.isLiga = true
                viewController.online = online
            }
            else{
                torneo.setNombre(s: nombre.text ?? "default")
                viewController.torneo = torneo
                viewController.online = online
            }
        }
    }

}


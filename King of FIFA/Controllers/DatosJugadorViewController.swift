//
//  DatosJugadorViewController.swift
//  King of FIFA
//
//  Created by Christian Valencia on 3/24/20.
//  Copyright © 2020 Christian Valencia. All rights reserved.
//

import UIKit

class DatosJugadorViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var titulo: UITextField!
    @IBOutlet weak var nombre: UITextField!
    @IBOutlet weak var userID: UITextField!
    @IBOutlet weak var equipo: UITextField!
    
    var torneo = Torneo()
    private var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nombre.delegate = self
        userID.delegate = self
        equipo.delegate = self
   
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func endEdit(_ sender: UITextField) {
           sender.resignFirstResponder()
       }
    
    @IBAction func siguiente(_ sender: UIButton) {
        
        let n: String = nombre.text ?? "Default"
        let u: String = userID.text ?? "Default"
        let e: String = equipo.text ?? "Default"
        let j = Jugador(n: n, u: u, e: e)
        torneo.addJugador(jugador: j)
        count = count + 1
        if count >= torneo.getNum() {
            torneo.printTorneo()
            performSegue(withIdentifier: "Next", sender: nil)
        }
        updateView()
        
        
    }
    
    private func updateView()
    {
        titulo.text = "Jugador \(count + 1)"
        nombre.text = ""
        userID.text = ""
        equipo.text = ""
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let viewController = segue.destination as? TorneoCreadoViewController{
            viewController.torneo = torneo
        }
    }
    

}

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
        saveTorneo();
        // Do any additional setup after loading the view.
    }
    
    private func saveTorneo() {
        do{
            let t = try NSKeyedArchiver.archivedData(withRootObject: torneo, requiringSecureCoding: false)
            try t.write(to: Torneo.ArchiveURL)
        }
        catch {
            print("Couldn't write file")
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

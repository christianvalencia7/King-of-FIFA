//
//  NumJugadoresViewController.swift
//  King of FIFA
//
//  Created by Christian Valencia on 3/22/20.
//  Copyright © 2020 Christian Valencia. All rights reserved.
//

import UIKit

class NumJugadoresViewController: UIViewController {
    var torneo = Torneo()
    var selectedNum: Int = 0
    var online: Bool = false
    var email = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func botonJugadores(_ sender: UIButton) {
        selectedNum = sender.tag
        torneo.setNum(num: selectedNum)
        torneo.online = online
        torneo.creadoPor = email
        torneo.dateCreated = Date()
        performSegue(withIdentifier: "MasOpciones", sender: nil)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let viewController = segue.destination as? OpcionesTorneoViewController{
            viewController.torneo = torneo
            viewController.online = online
        }
    }
    

}

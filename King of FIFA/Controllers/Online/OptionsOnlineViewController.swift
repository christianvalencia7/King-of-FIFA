//
//  OptionsOnlineViewController.swift
//  King of FIFA
//
//  Created by Christian Valencia on 5/26/20.
//  Copyright © 2020 Christian Valencia. All rights reserved.
//

import UIKit
import Firebase

class OptionsOnlineViewController: UIViewController {

    var isLiga = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func manualEntry(_ sender: Any) {
        if(!isLiga) {
            performSegue(withIdentifier: "toCreateTorneo", sender: nil)
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? NumJugadoresViewController{
            viewController.online = true
            viewController.email = Auth.auth().currentUser!.email!
        }
    }

}

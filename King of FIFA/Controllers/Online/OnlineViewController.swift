//
//  CrearTorneoViewController.swift
//  King of FIFA
//
//  Created by Christian Valencia on 3/25/20.
//  Copyright © 2020 Christian Valencia. All rights reserved.
//

import UIKit
import Firebase
class OnlineViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func logOut(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            
        } catch {
            print("error")
        }
    }
    
    
    
    @IBAction func unwindSegueToOnline(_ sender: UIStoryboardSegue)
    {
        
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? LigasTableViewController{
            viewController.online = true
        }
    }

}

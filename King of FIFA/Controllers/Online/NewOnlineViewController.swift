//
//  NewOnlineViewController.swift
//  King of FIFA
//
//  Created by Christian Valencia on 5/13/20.
//  Copyright © 2020 Christian Valencia. All rights reserved.
//

import UIKit

class NewOnlineViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? NumJugadoresViewController{
            viewController.online = true
        }
    }
    

}

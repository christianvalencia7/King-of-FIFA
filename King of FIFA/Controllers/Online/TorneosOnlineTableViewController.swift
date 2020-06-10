//
//  TorneosOnlineTableViewController.swift
//  King of FIFA
//
//  Created by Christian Valencia on 5/28/20.
//  Copyright © 2020 Christian Valencia. All rights reserved.
//

import UIKit
import Firebase

class TorneosOnlineTableViewController: UITableViewController {

    var torneos = [Torneo]()
    var selectedTorneo = 0
    var newTorneo = false
    override func viewDidLoad() {
       super.viewDidLoad()

       // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
       //self.navigationItem.rightBarButtonItem = self.
       loadTorneos()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
       // #warning Incomplete implementation, return the number of sections
       return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // #warning Incomplete implementation, return the number of rows
       return torneos.count
    }

    @IBAction func unwindSegueToOnlineTorneos(_ sender: UIStoryboardSegue)
    {
          if let sourceViewController = sender.source as? TorneoCreadoViewController {
               let torneo = sourceViewController.torneo
               let newIndexPath = IndexPath(row: torneos.count, section: 0)
               torneos.append(torneo)
               tableView.insertRows(at: [newIndexPath], with: .automatic)
           }

           
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "Red", for: indexPath) as! NombreTorneoTableViewCell
       // Configure the cell...
       
       cell.nombre.text = "\(torneos[indexPath.row].nombre)"
       cell.nombre.textColor = UIColor.white

       return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedTorneo = indexPath.row
        performSegue(withIdentifier: "FaseTorneo", sender: nil)
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
       // Return false if you do not want the specified item to be editable.
       return true
    }
    */


    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
       
       if editingStyle == .delete {
           //deleteTorneo(torneo: torneos[indexPath.row])
           torneos.remove(at: indexPath.row)
           tableView.deleteRows(at: [indexPath], with: .fade)
       } else if editingStyle == .insert {
           // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
       }
    }


    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
       // Return false if you do not want the item to be re-orderable.
       return true
    }
    */


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       // Get the new view controller using segue.destination.
       // Pass the selected object to the new view controller.
       if let viewController = segue.destination as? FaseTorneoTableViewController {
           viewController.torneo = torneos[selectedTorneo]
           viewController.selectedTorneo = selectedTorneo
       }
       
    }

    //MARK: - FILE MANAGMENT

    private func loadTorneos()  {
        let fireStoreDatabase = Firestore.firestore()
        
        fireStoreDatabase.collection(Auth.auth().currentUser!.email!).document("Competencias").collection("Torneos").getDocuments { (snapshot, error) in
            if error != nil {
                print(error?.localizedDescription ?? "ERROR")
            } else {
                if snapshot?.isEmpty != true && snapshot != nil {
                    for document in snapshot!.documents {
                        let data = document.data()
                        for (_, j) in data {
                            do{
                                let data = try? JSONSerialization.data(withJSONObject: j as Any, options: [])
                                let torneo = try JSONDecoder().decode(Torneo.self, from: data!)
                                torneo.printTorneo()
                                self.torneos.append(torneo)
                            }
                            catch {
                                print(error.localizedDescription)
                            }

                        }
                        self.tableView.reloadData()
                    }
                }
                
            }
            
        }
    }

//    private func deleteTorneo(torneo: Torneo) {
//
//    }


}

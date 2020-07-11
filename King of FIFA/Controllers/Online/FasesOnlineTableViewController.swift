//
//  FasesOnlineTableViewController.swift
//  King of FIFA
//
//  Created by Christian Valencia on 6/17/20.
//  Copyright © 2020 Christian Valencia. All rights reserved.
//

import UIKit
import Firebase

class FasesOnlineTableViewController: UITableViewController {
    
    var torneo = Torneo()
    var selectedTorneo = 0
    var selectedPartido = 0
    var torneoid = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTorneo()
        let numPartidos = torneo.partidos.count
        var fase = ""
        if numPartidos == 1 { fase = "Final"}
        if numPartidos == 2 { fase = "Semifinal"}
        if numPartidos == 4 { fase = "Cuartos de final"}
        if numPartidos == 8 { fase = "Octavos de final"}
        if numPartidos == 16 { fase = "16avos de final"}
        if numPartidos == 32 { fase = "32avos de final"}
        self.navigationItem.title = fase
        self.navigationItem.prompt = torneo.nombre

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        //self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return torneo.partidos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Red", for: indexPath) as! NombreTorneoTableViewCell
        // Configure the cell...
        
        cell.nombre.text = "\(torneo.partidos[indexPath.row].toString())"
        cell.nombre.textColor = UIColor.white

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         selectedPartido = indexPath.row
         performSegue(withIdentifier: "toMarcador", sender: nil)
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
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
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
        if let viewController = segue.destination as? MarcadorViewController {
            viewController.torneo = torneo
            viewController.selectedTorneo = selectedTorneo
            viewController.selectedPartido = selectedPartido
            viewController.isOnline = true
        }
        
    }
    
    @IBAction func siguienteFase(_ sender: UIBarButtonItem) {
        let partidos = torneo.partidos
        var empate = 0
        for p in partidos {
            if p.goles1 == p.goles2{
                empate = empate + 1
            }
        }
        //Check if there is a draw
        if empate > 0 {
            let alertController = UIAlertController(title: "No puede haber empate", message: "En caso de empate jugar tiempos extra, penales u otro partido de desempate", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alertController, animated: true, completion: nil)
        }
            
        //If there isn't a draw continue to next stage
        else {
            for p in partidos{
                torneo.jugadores.append(p.getGanador())
                torneo.partidos.remove(at: 0)
            }
            torneo.crearPartidos()
            tableView.reloadData()
            self.refreshControl?.endRefreshing()
            
            var fase = ""
            let numPartidos = torneo.partidos.count
            if numPartidos == 1 { fase = "Final"}
            if numPartidos == 2 { fase = "Semifinal"}
            if numPartidos == 4 { fase = "Cuartos de final"}
            if numPartidos == 8 { fase = "Octavos de final"}
            if numPartidos == 16 { fase = "16avos de final"}
            if numPartidos == 32 { fase = "32avos de final"}
            self.navigationItem.title = fase
            uploadTorneo(torneo: torneo)
            if numPartidos == 0
            {
                let alertController = UIAlertController(title: "FIN DEL TORNEO", message: "El ganador es \(torneo.jugadores[0].nombre)", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alertController, animated: true, completion: nil)
            }
        }
        
    }
    
    @IBAction func unwindSegueToFasesOnline(_ sender: UIStoryboardSegue)
    {

    }
    
    //FILE MANAGMENT
     private func loadTorneo()  {
        let fireStoreDatabase = Firestore.firestore()
        fireStoreDatabase.collection(Auth.auth().currentUser!.email!).document("Competencias").collection("Torneos").getDocuments { (snapshot, error) in
            if error != nil {
                print(error?.localizedDescription ?? "ERROR")
            } else {
                if snapshot?.isEmpty != true && snapshot != nil {
                    for document in snapshot!.documents {
                        if document.documentID.elementsEqual(self.torneoid){
                            let data = document.data()
                            do{
                                let d = try? JSONSerialization.data(withJSONObject: data[self.torneo.nombre] as Any, options: [])
                                self.torneo = try JSONDecoder().decode(Torneo.self, from: d!)
                            }
                            catch {
                                print(error.localizedDescription)
                            }
                        }
                    }
                }
                
            }
            
        }
    }
    
    private func uploadTorneo(torneo: Torneo) {
        let firestoreDatabase = Firestore.firestore()
        do {
            let jsonData = try JSONEncoder().encode(torneo)
            let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
            let firestoreTorneo = [torneo.nombre : jsonObject] as [String : Any]

            firestoreDatabase.collection(torneo.creadoPor).document("Competencias").collection("Torneos").document(torneo.id.uuidString).setData(firestoreTorneo)
        }
        catch {
            print("ERROR!!! \(error.localizedDescription)")
        }
        
    }
    

}

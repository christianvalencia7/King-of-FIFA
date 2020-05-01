//
//  FaseTorneoTableViewController.swift
//  King of FIFA
//
//  Created by Christian Valencia on 4/2/20.
//  Copyright © 2020 Christian Valencia. All rights reserved.
//

import UIKit

class FaseTorneoTableViewController: UITableViewController {
    
    var torneo = Torneo()
    var selectedTorneo = 0
    var selectedPartido = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
         performSegue(withIdentifier: "CambiarMarcador", sender: nil)
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
        }
        
    }
    
    private func loadTorneos() -> [Torneo]?  {
        if let torneos = getObject(fileName: "torneos") as? [Torneo]{
            return torneos
        }
        else{
            print("TORNEO NOT LOADED")
            return nil
        }
    }
    
    func getObject(fileName: String) -> Any? {
        
        let filePath = self.getDirectoryPath().appendingPathComponent(fileName)//5
        do {
            let data = try Data(contentsOf: filePath)//6
            let object = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data)//7
            return object//8
        } catch {
            print("error is: \(error.localizedDescription)")//9
        }
        return nil
    }
    
    func getDirectoryPath() -> URL {
        let arrayPaths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return arrayPaths[0]
    }
    

}

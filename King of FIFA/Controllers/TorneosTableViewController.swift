//
//  TorneosTableViewController.swift
//  King of FIFA
//
//  Created by Christian Valencia on 3/27/20.
//  Copyright © 2020 Christian Valencia. All rights reserved.
//

import UIKit

class TorneosTableViewController: UITableViewController {
    
    var torneos = [Torneo]()
    var selectedTorneo = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        //torneos = loadTorneos() ?? Torneo()
        //torneos.printTorneo()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        torneos = loadTorneos() ?? [Torneo]()
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
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return torneos.count
    }

    @IBAction func unwindSeguefromTorneoCreadotoTable(_ sender: UIStoryboardSegue)
    {
           if let sourceViewController = sender.source as? TorneoCreadoViewController {
                let torneo = sourceViewController.torneo
                let newIndexPath = IndexPath(row: torneos.count, section: 0)
                torneos.append(torneo)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
    
            saveTorneo()
    }
    
    private func saveTorneo() {

        if(!saveObject(fileName: "torneos", object: torneos))
        {
                print("TORNEO NOT SAVED")
        }
    }
    
    func saveObject(fileName: String, object: Any) -> Bool {
        
        let filePath = self.getDirectoryPath().appendingPathComponent(fileName)//1
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: object, requiringSecureCoding: false)//2
            try data.write(to: filePath)//3
            return true
        } catch {
            print("error is: \(error.localizedDescription)")//4
        }
        return false
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
            viewController.torneos = torneos
            viewController.selectedTorneo = selectedTorneo
        }
        
    }
    

}

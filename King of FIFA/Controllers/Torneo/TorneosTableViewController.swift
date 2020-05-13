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
    var newTorneo = false
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        //self.navigationItem.rightBarButtonItem = self.
        torneos = loadTorneos() ?? [Torneo]()
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

    @IBAction func unwindSegueToTorneo(_ sender: UIStoryboardSegue)
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
            deleteTorneo(torneo: torneos[indexPath.row])
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
    
    //FILE MANAGMENT
    
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
        var ts = [Any]()
        let filePath2 = self.getDirectoryPath().appendingPathComponent("torneos", isDirectory: true)
        var components = [String]()
        
        do{
            if FileManager.default.fileExists(atPath: filePath2.path){
                components = try FileManager.default.contentsOfDirectory(atPath: filePath2.path)
                var i = 0
                while i < components.count{
                    
                        let component = components[i]
                        i = i + 1
                        let data = try Data(contentsOf: filePath2.appendingPathComponent(component))
                        let object = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data)
                        ts.append(object!)
                }
            }
        }
        catch {print("1error is: \(error.localizedDescription)")}
        return ts
    }
    
    private func deleteTorneo(torneo: Torneo) {

        if(!deleteObject(fileName: "\(torneo.id)", object: torneo))
        {
                print("TORNEO NOT SAVED")
        }
    }
    
    func deleteObject(fileName: String, object: Any) -> Bool {
        do{
            if !FileManager.default.fileExists(atPath: getDirectoryPath().appendingPathComponent("torneos", isDirectory: true).path) {
                try FileManager.default.createDirectory(at: self.getDirectoryPath().appendingPathComponent("torneos", isDirectory: true), withIntermediateDirectories: true, attributes: nil)
            }
        }
        catch{print("CATCH")}
        let f = self.getDirectoryPath().appendingPathComponent("torneos", isDirectory: true)
        let filePath = f.appendingPathComponent(fileName)//1
        do {
            try FileManager.default.removeItem(atPath: filePath.path)
            return true
        } catch {
            print("7error is: \(error.localizedDescription)")//4
        }
        return false
    }
    
    func getDirectoryPath() -> URL {
        let arrayPaths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return arrayPaths[0]
    }

}



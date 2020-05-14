//
//  LigasTableViewController.swift
//  King of FIFA
//
//  Created by Christian Valencia on 5/4/20.
//  Copyright © 2020 Christian Valencia. All rights reserved.
//

import UIKit

class LigasTableViewController: UITableViewController {
    
    var ligas = [Liga]()
    var selectedLiga = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        //self.navigationItem.rightBarButtonItem = self.
        ligas = loadLigas() ?? [Liga]()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ligas.count
    }

    @IBAction func unwindSegueToLigas(_ sender: UIStoryboardSegue)
    {
           if let sourceViewController = sender.source as? TorneoCreadoViewController {
                //let liga = sourceViewController.liga
                let newIndexPath = IndexPath(row: ligas.count, section: 0)
                //ligas.append(liga)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
    
            
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Red", for: indexPath) as! NombreTorneoTableViewCell
        // Configure the cell...
        
        cell.nombre.text = "\(ligas[indexPath.row].nombre)"
        cell.nombre.textColor = UIColor.white

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         selectedLiga = indexPath.row
         //performSegue(withIdentifier: "FaseTorneo", sender: nil)
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
            deleteLiga(liga: ligas[indexPath.row])
            ligas.remove(at: indexPath.row)
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
            //viewController.torneo = torneos[selectedTorneo]
            //viewController.selectedTorneo = selectedTorneo
        }
        
    }
    
    //FILE MANAGMENT
    
    private func loadLigas() -> [Liga]?  {
           if let ligas = getObject(fileName: "ligas") as? [Liga]{
               return ligas
           }
           else{
               print("LIGA NOT LOADED")
               return nil
           }
       }
    
    func getObject(fileName: String) -> Any? {
        var ts = [Any]()
        let filePath2 = self.getDirectoryPath().appendingPathComponent("ligas", isDirectory: true)
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
    
    private func deleteLiga(liga: Liga) {

        if(!deleteObject(fileName: "\(liga.id)", object: liga))
        {
                print("LIGA NOT DELEATED")
        }
    }
    
    func deleteObject(fileName: String, object: Any) -> Bool {
        do{
            if !FileManager.default.fileExists(atPath: getDirectoryPath().appendingPathComponent("ligas", isDirectory: true).path) {
                try FileManager.default.createDirectory(at: self.getDirectoryPath().appendingPathComponent("ligas", isDirectory: true), withIntermediateDirectories: true, attributes: nil)
            }
        }
        catch{print("CATCH")}
        let f = self.getDirectoryPath().appendingPathComponent("ligas", isDirectory: true)
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

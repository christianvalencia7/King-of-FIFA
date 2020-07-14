//
//  FechasTableViewController.swift
//  King of FIFA
//
//  Created by Christian Valencia on 5/16/20.
//  Copyright © 2020 Christian Valencia. All rights reserved.
//

import UIKit
import Firebase

class FechasTableViewController: UITableViewController {

    var liga = Liga()
    var selectedLiga = 0
    var selectedPartido = 0
    var online = false
    var fin = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Fecha \(liga.getFecha())"
        self.navigationItem.prompt = liga.nombre
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return liga.partidos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Red", for: indexPath) as! NombreTorneoTableViewCell
        // Configure the cell...
        
        cell.nombre.text = "\(liga.partidos[indexPath.row].toString())"
        cell.nombre.textColor = UIColor.white

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         selectedPartido = indexPath.row
        if !fin {
            performSegue(withIdentifier: "toMarcador", sender: nil)
        }
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
        
        if let viewController = segue.destination as? MarcadorViewController {
            viewController.liga = liga
            viewController.isLiga = true
            viewController.selectedPartido = selectedPartido
        }
        if let viewController = segue.destination as? PosicionesTableViewController {
            viewController.liga = liga
            viewController.fin = fin
            viewController.online = online
        }
        
    }
    
    @IBAction func siguienteFecha(_ sender: UIBarButtonItem) {
        if liga.crearPartidos(){
            if online {
                uploadLiga(liga: liga)
            }
            
            else {
                saveLiga(liga: liga)
            }
            
            tableView.reloadData()
            self.refreshControl?.endRefreshing()
            self.navigationItem.title = "Fecha \(liga.getFecha())"
        }
            
        else{
            if online {
                uploadLiga(liga: liga)
            }
            
            else {
                saveLiga(liga: liga)
            }
            fin = true
            performSegue(withIdentifier: "toPosiciones", sender: nil)
        }
        
        
    }
    
    @IBAction func unwindSegueToFechas(_ sender: UIStoryboardSegue)
    {
            //torneo = loadTorneo(torneo: torneo)!
//          if let sourceViewController = sender.source as? TorneoCreadoViewController {
//                let torneo = sourceViewController.torneo
//                let newIndexPath = selectedPartido
//                let indexPath: IndexPath = IndexPath(row: selectedPartido, section: 0)
//                tableView.deleteRows(at: [indexPath], with: .fade)
//                tableView.insertRows(at: [indexPath], with: .automatic)
//          }
    
            
    }
    
    //FILE MANAGMENT
    private func loadTorneo(torneo: Torneo) -> Torneo?  {
           if let torneos = getObject(fileName: "\(torneo.id)") as? Torneo{
               return torneos
           }
           else{
               print("TORNEO NOT LOADED")
               return nil
           }
       }
    
    func getObject(fileName: String) -> Any? {
        let filePath2 = self.getDirectoryPath().appendingPathComponent("torneos", isDirectory: true)
    
        do{
            if FileManager.default.fileExists(atPath: filePath2.path){
                let data = try Data(contentsOf: filePath2.appendingPathComponent(fileName))
                let object = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data)
                return object
            }
        }
        catch {print("1error is: \(error.localizedDescription)")}
        return nil
    }
    
    private func saveLiga(liga: Liga) {

        if(!saveObject(fileName: "\(liga.id)", object: liga))
        {
                print("LIGA NOT SAVED")
        }
    }
    
    func saveObject(fileName: String, object: Any) -> Bool {
        do{
            if !FileManager.default.fileExists(atPath: getDirectoryPath().appendingPathComponent("ligas", isDirectory: true).path) {
                try FileManager.default.createDirectory(at: self.getDirectoryPath().appendingPathComponent("ligas", isDirectory: true), withIntermediateDirectories: true, attributes: nil)
                print("\(try FileManager.default.contentsOfDirectory(atPath: self.getDirectoryPath().path))")
            }
        }
        catch{print("CATCH")}
        let f = self.getDirectoryPath().appendingPathComponent("ligas", isDirectory: true)
        let filePath = f.appendingPathComponent(fileName)//1
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: object, requiringSecureCoding: false)//2
            try data.write(to: filePath)//3
            return true
        } catch {
            print("2error is: \(error.localizedDescription)")//4
        }
        return false
    }
    
    func getDirectoryPath() -> URL {
        let arrayPaths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return arrayPaths[0]
    }
    
    private func uploadLiga(liga: Liga) {
        let firestoreDatabase = Firestore.firestore()
        do {
            let jsonData = try JSONEncoder().encode(liga)
            let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
            let firestoreTorneo = [liga.nombre : jsonObject] as [String : Any]

            firestoreDatabase.collection(liga.creadoPor).document("Competencias").collection("Ligas").document(liga.id.uuidString).setData(firestoreTorneo)
        }
        catch {
            print("ERROR!!! \(error.localizedDescription)")
        }
    }

}

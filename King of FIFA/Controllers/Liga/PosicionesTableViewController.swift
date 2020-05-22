//
//  PosicionesTableViewController.swift
//  King of FIFA
//
//  Created by Christian Valencia on 5/19/20.
//  Copyright © 2020 Christian Valencia. All rights reserved.
//

import UIKit

class PosicionesTableViewController: UITableViewController {
    
    var fin = false
    var liga = Liga()
    var datos = [[Any]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        liga = loadLiga(liga: liga)!
        for j in liga.jugadores {
            var temp = [j,0,0] as [Any]
            for p in liga.resultados {
                let js = "\(j.nombre+j.userID)" as String
                let j1 = "\(p.jugador1.nombre+p.jugador1.userID)" as String
                let j2 = "\(p.jugador2.nombre+p.jugador2.userID)" as String
                if js.isEqual(j1) {
                    let golDif = p.goles1 - p.goles2
                    var puntos = 0
                    if golDif > 0 { puntos = 3}
                    if golDif == 0 {puntos = 1}
                    temp[1] = temp[1] as! Int + golDif
                    temp[2] = temp[2] as! Int + puntos
                }
                
                if js.isEqual(j2) {
                    let golDif = p.goles2 - p.goles1
                    var puntos = 0
                    if golDif > 0 { puntos = 3}
                    if golDif == 0 {puntos = 1}
                    temp[1] = temp[1] as! Int + golDif
                    temp[2] = temp[2] as! Int + puntos
                }
                
            }
            datos.append(temp)
        }
        datos.sort { (a, b) -> Bool in
            if a[2] as! Int == b[2] as! Int{
                return a[1] as! Int > b[1] as! Int
            }
            
            return a[2] as! Int > b[2] as! Int
        }
        
        if fin {
            let alertController = UIAlertController(title: "FIN DE LA LIGA", message: "El ganador es \((datos[0][0] as! Jugador).nombre)", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alertController, animated: true, completion: nil)
        }
        
        

        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return liga.jugadores.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PosicionesCell", for: indexPath) as! PosicionesTableViewCell
        // Configure the cell...
        let js = datos[indexPath.row][0] as! Jugador
        let golDif = datos[indexPath.row][1] as! Int
        let puntos = datos[indexPath.row][2] as! Int
        cell.nombreLabel.text = "\(js.nombre)"
        cell.golLabel.text = "\(golDif)"
        cell.puntosLabel.text = "\(puntos)"
        cell.posLabel.text = "\(indexPath.row + 1)"
        //cell.nombreLabel.textColor = UIColor.white

        return cell
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    //FILE MANAGMENT
    private func loadLiga(liga: Liga) -> Liga?  {
           if let liga = getObject(fileName: "\(liga.id)") as? Liga{
               return liga
           }
           else{
               print("Liga NOT LOADED")
               return nil
           }
       }
    
    func getObject(fileName: String) -> Any? {
        let filePath2 = self.getDirectoryPath().appendingPathComponent("ligas", isDirectory: true)
    
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
    
    func getDirectoryPath() -> URL {
        let arrayPaths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return arrayPaths[0]
    }

}

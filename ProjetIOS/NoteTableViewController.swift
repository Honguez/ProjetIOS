//
//  NoteTableViewController.swift
//  ProjetIOS
//
//  Created by ruello nathan on 04/03/2021.
//

import UIKit

class NoteTableViewController: UITableViewController {
    
    var notes: [Note]=[
        Note(titre: "Note1", contenu:"test1", date: "02/10/2021 10:30", location: "Paris"),
        Note(titre: "Note2", contenu:"test2", date: "03/11/2021 08:45", location: "Belfort"),
        Note(titre: "Note3", contenu:"test3", date: "04/12/2021 02:15", location: "Montpelier"),
        Note(titre: "Note4", contenu:"test4", date: "05/12/2021 12:15", location: "Londre"),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    @IBAction func unwindNoteTableView(segue: UIStoryboardSegue) {
        if segue.identifier == "saveUnwind"{
            let sourceVC = segue.source as! AddEditTableViewController
            
            if let note = sourceVC.note {
                if let selectedIndexPath = tableView.indexPathForSelectedRow{
                    //Modification
                    self.notes[selectedIndexPath.row] = note
                    tableView.reloadData()
                }else{
                    //Création
                    self.notes.append(note)
                    tableView.reloadData()
                }
                       
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return notes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath)

        let note = notes[indexPath.row]
        
        cell.textLabel?.text = note.titre
        cell.detailTextLabel?.text = note.date
        return cell
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
            notes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let movednote = notes.remove(at:fromIndexPath.row)
    
        notes.insert(movednote, at: to.row)
        tableView.reloadData()
        
    }
    
    
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
        if segue.identifier == "EditNote"{//cas où l'utilisateur clique sur une ligne
            
            let indexPath = tableView.indexPathForSelectedRow!
            let note = notes[indexPath.row]
            let navController = segue.destination as! UINavigationController
            let addEditVC = navController.topViewController as! AddEditTableViewController
            addEditVC.note = note
            
            
        }
        
    }
    
    

}

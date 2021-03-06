//
//  AddEditTableViewController.swift
//  ProjetIOS
//
//  Created by ruello nathan on 04/03/2021.
//

import UIKit
import MapKit
import CoreLocation

class AddEditTableViewController: UITableViewController, CLLocationManagerDelegate {
	
    @IBOutlet weak var titreTF: UITextField!
    @IBOutlet weak var contenuTF: UITextField!
    @IBOutlet weak var saveEditCreateButton: UIBarButtonItem!
    @IBOutlet var mapView : MKMapView!
    
    let manager = CLLocationManager()
    private var location : CLLocation!
    
    
    
    
    
    
    var note : Note?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        saveEditCreateButton.isEnabled = false
        if let note = self.note{
            titreTF.text = note.titre
            contenuTF.text = note.contenu
            //location
            
        }
    }
        
    @IBAction func UpdateLoc(_ sender: Any) {
        
        render(location)
        
    }
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
        
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){

            location = locations.first
            render(location)
        
    }
        
    func render(_ location: CLLocation){
        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: coordinate, span: span )
        mapView .setRegion(region, animated: true)
            
        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
        mapView.addAnnotation(pin)
        }
        
    
    @IBAction func EditingDidChangeContenu(_ sender: UITextField) {
        if titreTF.text != "" && contenuTF.text != "" {
            saveEditCreateButton.isEnabled = true
        }else{
            saveEditCreateButton.isEnabled = false
        }
    }
    
    @IBAction func EditingDidChangeTitle(_ sender: UITextField) {
        if titreTF.text != "" && contenuTF.text != "" {
            saveEditCreateButton.isEnabled = true
        }else{
            saveEditCreateButton.isEnabled = false
        }
    }
    // MARK: - Table view data source
/*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }*/
/*
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }*/

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
        if segue.identifier == "saveUnwind"{
            
            let titre = titreTF.text ?? ""
            let contenu = contenuTF.text ?? ""
            
            //conversion Date to String
            let dateForm = DateFormatter()
            dateForm.dateFormat = "dd/MM/YYYY  HH:mm"
            let date = dateForm.string(from:Date())
            
            let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            self.note = Note(titre: titre, contenu: contenu, date : date, location: coordinate)
            
        }

    }
    

}

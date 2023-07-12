//
//  ViewController.swift
//  SimpsonBook
//
//  Created by Cem Bıçakcı on 12.07.2023.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var mySimpsons = [Simpson]()
    var chosenSimpson : Simpson?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //Simpson Objects
        let homer = Simpson(name: "Homer Simpson", job: "Nuclear Safety", image: UIImage(named: "homer_simpson")!)
        let marge = Simpson(name: "Merge Simpson", job: "House Wife", image: UIImage(named: "merge_simpson")!)
        let bart = Simpson(name: "Bart Simpson", job: "Student", image: UIImage(named: "bart_simpson")!)
        let lisa = Simpson(name: "Lisa Simpson", job: "Student", image: UIImage(named: "lisa_simpson")!)
        let maggie = Simpson(name: "Maggies Simpson", job: "Baby", image: UIImage(named: "maggie_simpson")!)
        
        mySimpsons.append(homer)
        mySimpsons.append(marge)
        mySimpsons.append(bart)
        mySimpsons.append(lisa)
        mySimpsons.append(maggie)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mySimpsons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = mySimpsons[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenSimpson = mySimpsons[indexPath.row]
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "toDetailsVC") {
            let destinationVC = segue.destination as! DetailsVC
            destinationVC.selectedSimpson = chosenSimpson
        }
    }


}


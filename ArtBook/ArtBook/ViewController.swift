//
//  ViewController.swift
//  ArtBook
//
//  Created by Cem Bıçakcı on 12.07.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //navigation daki header a ulaşma ve item ekleme
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonClicked))
    }
    
    @objc func addButtonClicked(){
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }


}


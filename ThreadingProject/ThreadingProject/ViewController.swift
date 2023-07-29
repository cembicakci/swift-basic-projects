//
//  ViewController.swift
//  ThreadingProject
//
//  Created by Cem Bıçakcı on 29.07.2023.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageView: UIImageView!
    
    let urlStrings =
    ["https://cdn.wallpapersafari.com/71/1/sqgkKV.jpg", "https://upload.wikimedia.org/wikipedia/commons/7/74/Earth_poster_large.jpg"]
    
    var data = Data()

    var tracker = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        DispatchQueue.global().async {
            self.data = try! Data(contentsOf: URL(string: self.urlStrings[self.tracker])!) //background thread
            
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: self.data) //main thread
            }
            
        }
            
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.compose, target: self, action: #selector(changeImage))
        
    }
    
    @objc func changeImage(){
        
        if(tracker == 0){
            tracker = 1
        }else{
            tracker = 0
        }
        
        DispatchQueue.global().async {
            self.data = try! Data(contentsOf: URL(string: self.urlStrings[self.tracker])!) //backgroung thread
            
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: self.data) //main thread
            }
    
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Threading Test"
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 25
    }


}


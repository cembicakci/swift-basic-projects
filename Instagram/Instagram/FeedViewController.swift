//
//  FeedViewController.swift
//  Instagram
//
//  Created by Cem Bıçakcı on 16.07.2023.
//

import UIKit

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Prorotype cell i 1 yaptıktan sonra, tableViewCell ismine "cell" dedik.
        //Burada oluşturduğumuz cell isimle tableViewCell e ulaşıyoruz içerisini dolduruyoruz.
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FeedCell
        cell.userEmail.text = "test.gmail.com"
        cell.commentLabel.text = "comment"
        cell.likeLabel.text = "1"
        cell.userImageView.image = UIImage(named: "click")
        return cell
    }

}

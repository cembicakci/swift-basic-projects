//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Cem Bıçakcı on 16.07.2023.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var cadLabel: UILabel!
    @IBOutlet weak var chfLabel: UILabel!
    @IBOutlet weak var gbpLabel: UILabel!
    @IBOutlet weak var jpyLabel: UILabel!
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var tryLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func getRatesClicked(_ sender: Any) {
        
        // 1) Request & Session
        // 2) Response & Data
        // 3) Parsing & JSON Serialization
        
        //Http bağlantılara istek atarken
        //Info kısmıdan => App Transport Security Settings => Allow Arbitrary Loads => YES
        
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=641e18fb5a8d53f99e7fa3d22026af07")
        let session = URLSession.shared
        
        //Closure
        let task = session.dataTask(with: url!) { data, response, error in
            if (error != nil){
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default)
                alert.addAction(okButton)
                self.present(alert, animated: true)
            }else{
                    
                if(data != nil){
                    
                    do{
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
                        
                        //ASYNC
                        DispatchQueue.main.async {
                            
                            if let rates = jsonResponse["rates"] as? [String : Any]{
                                
                                if let cad = rates["CAD"] as? Double{
                                    self.cadLabel.text = "CAD: \(cad)"
                                }
                                
                                if let chf = rates["CHF"] as? Double{
                                    self.chfLabel.text = "CHF: \(chf)"
                                }
                                
                                if let gbp = rates["GBP"] as? Double{
                                    self.gbpLabel.text = "GBP: \(gbp)"
                                }
                                
                                if let jpy = rates["JPY"] as? Double{
                                    self.jpyLabel.text = "JPY: \(jpy)"
                                }
                                
                                if let usd = rates["USD"] as? Double{
                                    self.usdLabel.text = "USD: \(usd)"
                                }
                                
                                if let tr = rates["TRY"] as? Double{
                                    self.tryLabel.text = "TRY: \(tr)"
                                }
                            }
                            
                        }
                        
                    }catch{
                        print("Error")
                    }
                    
                }
                
            }
        }
        
        //task i çalıştırıyor.
        task.resume()
        
        
    }
}


//
//  ViewController.swift
//  Currency Api&JSON
//
//  Created by Gökberk on 22.12.2020.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tryLabel: UILabel!
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var gbpLabel: UILabel!
    @IBOutlet weak var jpyLabel: UILabel!
    @IBOutlet weak var cadLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getData()
    }

    @IBAction func refresh(_ sender: Any) {
        getData()
    }
    
    
    func getData() {
        
        //1 Request & Session
        //2 Response & Data
        //3 Parsing Json
        
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=9814535510cedc185041b4aaeef1e5bc")
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url!) { (data, response, error) in
            
            if error != nil {
                let alert = UIAlertController(title: "Error!!", message: error?.localizedDescription, preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
                    
                }))
                self.present(alert, animated: true, completion: nil)
                
            }
            
            else {
                
                if data != nil {
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String,Any>
                        
                        DispatchQueue.main.async {
                            print(jsonResponse)
                            if let rates = jsonResponse["rates"] as? [String : Any] {
                                //print(rates)
                           
                                if let turkish = rates["TRY"] as? Double {
                                    self.tryLabel.text = "TRY: \(turkish)"
                                }
                                if let cad = rates["CAD"] as? Double {
                                    self.cadLabel.text = "CAD: \(cad)"
                                }
                                if let usd = rates["USD"] as? Double {
                                    self.usdLabel.text = "USD: \(usd)"
                                }
                                if let gbp = rates["GBP"] as? Double {
                                    self.gbpLabel.text = "GBP: \(gbp)"
                                }
                                if let jpy = rates["JPY"] as? Double {
                                    self.jpyLabel.text = "JPY: \(jpy)"
                                }
                            
                            
                            
                            }
                            
                            }
                        
                        
                        
                    }
                    catch {
                        
                    }
                }
                
                
                
            }
            
            
        }
        
        task.resume()
    }

}

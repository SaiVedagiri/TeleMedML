//
//  SymptomsVC.swift
//  TeleMedML
//
//  Created by Arya Tschand on 5/23/20.
//  Copyright © 2020 aryatschand. All rights reserved.
//

import UIKit

class SymptomsVC: UIViewController {
    
    
    @IBOutlet weak var TempEntry: UITextField!
    @IBOutlet weak var TempSlider: UISlider!
    
    @IBOutlet weak var Headache: UISegmentedControl!
    @IBOutlet weak var Cough: UISegmentedControl!
    @IBOutlet weak var Sneezing: UISegmentedControl!
    @IBOutlet weak var Congestion: UISegmentedControl!
    
    @IBOutlet weak var Symptoms: UITextView!
    
    var temperatureVal = ""
    var headacheval = ""
    var coughVal = ""
    var sneezeVal = ""
    var congestionVal = ""
    var symptomsVal = ""
    
    var returnHash = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func SliderChanged(_ sender: Any) {
        TempEntry.text = String(TempSlider.value)
    }
    
    @IBAction func Check(_ sender: Any) {
        temperatureVal = String(TempSlider.value)
        headacheval = String(Headache.selectedSegmentIndex)
        coughVal = String(Cough.selectedSegmentIndex)
        sneezeVal = String(Sneezing.selectedSegmentIndex)
        congestionVal = String(Congestion.selectedSegmentIndex)
        symptomsVal = Symptoms.text
        getLeader(value2: "test")
    }
    
    func getLeader(value2: String) {
        printMessagesForUser(parameters: value2) {
            (returnval, error) in
            if (returnval)!
            {
                DispatchQueue.main.async {
                    if self.returnHash != "" {
                        self.performSegue(withIdentifier: "results", sender: self)
                    }
                }
            } else {
                print(error)
            }
        }
        DispatchQueue.main.async { // Correct
        }
    }
    
    func printMessagesForUser(parameters: String, CompletionHandler: @escaping (Bool?, Error?) -> Void){
        let json = [parameters]
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            
            
            let url = NSURL(string: "https://7c5a521b.ngrok.io/iphone/history")!
            let request = NSMutableURLRequest(url: url as URL)
            request.httpMethod = "POST"
            
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.setValue(temperatureVal, forHTTPHeaderField: "Temperature")
            
            let task = URLSession.shared.dataTask(with: request as URLRequest){ data, response, error in
                if let returned = String(data: data!, encoding: .utf8) {
                    print(returned)
                    CompletionHandler(true,nil)
                    
                    //self.Severity.text = "hello"
                } else {
                }
                
                //self.Severity.text = "test"
                
            }
            task.resume()
        } catch {
            
            print(error)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "results" {
            let ResultsVC = segue.destination as! ResultsVC
            ResultsVC.hashVal = returnHash
        }
    }
    
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

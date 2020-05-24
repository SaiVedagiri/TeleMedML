//
//  HistoryTVC.swift
//  TeleMedML
//
//  Created by Arya Tschand on 5/23/20.
//  Copyright © 2020 aryatschand. All rights reserved.
//

import UIKit
import Foundation
import SwiftyJSON

class HistoryTVC: UITableViewController {
    
    var patientData: [[String]] = []
    
    var jsonReturn = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getLeader(value2: "test")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return patientData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = patientData[indexPath.row][0] + " - " + patientData[indexPath.row][1]
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "btnClick" {
            let ResultsVC = segue.destination as! ResultsVC
            var selectedIndexPath = tableView.indexPathForSelectedRow
            var rowname: [String] = patientData[selectedIndexPath!.row]
            ResultsVC.patientData = rowname
            ResultsVC.showBtn = false
        }
    }
    
    func getLeader(value2: String) {
        printMessagesForUser(parameters: value2) {
            (returnval, error) in
            if (returnval)!
            {
                DispatchQueue.main.async {
                    if let data = self.jsonReturn.data(using: .utf8) {
                        if let json = try? JSON(data: data) {
                            for item in json["data"].arrayValue {
                                var appendArr: [String] = []
                                appendArr.append(item["timestamp"].stringValue)
                                appendArr.append(item["diagnosis"].stringValue)
                                appendArr.append(item["confidence"].stringValue)
                                appendArr.append(item["Temperature"].stringValue)
                                appendArr.append(item["Cough"].stringValue)
                                appendArr.append(item["Sneeze"].stringValue)
                                appendArr.append(item["Headache"].stringValue)
                                appendArr.append(item["Congestion"].stringValue)
                                self.patientData.append(appendArr)
                            }
                        }
                    }
                    self.tableView.reloadData()
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
            
            
            let url = NSURL(string: "https://telemedml.macrotechsolutions.us/history")!
            let request = NSMutableURLRequest(url: url as URL)
            request.httpMethod = "Get"
            
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            
            let task = URLSession.shared.dataTask(with: request as URLRequest){ data, response, error in
                if let returned = String(data: data!, encoding: .utf8) {
                    print(returned)
                    self.jsonReturn = returned
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

}

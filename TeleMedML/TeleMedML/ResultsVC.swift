//
//  ResultsVC.swift
//  TeleMedML
//
//  Created by Arya Tschand on 5/23/20.
//  Copyright © 2020 aryatschand. All rights reserved.
//

import UIKit

class ResultsVC: UIViewController {
    
    var showBtn = false
    
    var patientData:[String] = []

    @IBOutlet weak var virus: UILabel!
    @IBOutlet weak var Confidence: UILabel!
    @IBOutlet weak var CallBtn: UIButton!
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if showBtn {
            CallBtn.isHidden = false
            CallBtn.isEnabled = true
        } else {
            CallBtn.isHidden = true
            CallBtn.isEnabled = false
        }
        
        virus.text = patientData[1]
        
        let first4 = String(patientData[2].prefix(4))
        Confidence.text = first4 + "%"
        
        var txtString = ""
        txtString += "Temperature - " + patientData[3].prefix(4) + "\n"
        txtString += "Cough - " + patientData[4] + "\n"
        txtString += "Sneeze - " + patientData[5] + "\n"
        txtString += "Headache - " + patientData[6] + "\n"
        txtString += "Congestion - " + patientData[7] + "\n"
        textView.text = txtString
    }
    
    @IBAction func JoinCall(_ sender: Any) {
        self.performSegue(withIdentifier: "startCall", sender: self)
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

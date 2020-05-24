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
    var hashVal = ""

    @IBOutlet weak var virus: UILabel!
    @IBOutlet weak var Confidence: UILabel!
    @IBOutlet weak var CallBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var comps = hashVal.components(separatedBy: ",")
        if comps[0] == "yes" {
            CallBtn.isHidden = false
            CallBtn.isEnabled = true
        } else {
            CallBtn.isHidden = true
            CallBtn.isEnabled = false
        }
        
        virus.text = comps[1]
        Confidence.text = comps[2] + "%"
        
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

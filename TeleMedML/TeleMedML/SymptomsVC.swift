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
    
    override func viewDidLoad() {
        super.viewDidLoad()
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

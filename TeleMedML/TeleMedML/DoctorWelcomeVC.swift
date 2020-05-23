//
//  DoctorWelcomeVC.swift
//  TeleMedML
//
//  Created by Arya Tschand on 5/23/20.
//  Copyright © 2020 aryatschand. All rights reserved.
//

import UIKit

class DoctorWelcomeVC: UIViewController {
    
    var name = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnClick(_ sender: Any) {
        self.performSegue(withIdentifier: "doctorView", sender: self)
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

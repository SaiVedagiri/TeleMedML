//
//  LoginVC.swift
//  TeleMedML
//
//  Created by Arya Tschand on 5/23/20.
//  Copyright © 2020 aryatschand. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    
    @IBOutlet weak var Username: UITextField!
    @IBOutlet weak var Password: UITextField!
    
    var name = ""
    
    @IBAction func EnterClick(_ sender: Any) {
        if Username.text == "doctor" {
            self.performSegue(withIdentifier: "doctorlogin", sender: self)
        } else {
            self.performSegue(withIdentifier: "patientlogin", sender: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        name = Username.text!
        if segue.identifier == "doctorlogin" {
            let DoctorWelcomeVC = segue.destination as! DoctorWelcomeVC
            DoctorWelcomeVC.name = name
        } else {
            let PatientWelcomeVC = segue.destination as! PatientWelcomeVC
            PatientWelcomeVC.name = name
        }
    }

}

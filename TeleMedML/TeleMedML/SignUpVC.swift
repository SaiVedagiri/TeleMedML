//
//  SignUpVC.swift
//  TeleMedML
//
//  Created by Arya Tschand on 5/23/20.
//  Copyright © 2020 aryatschand. All rights reserved.
//

import UIKit
import Parse



class SignUpVC: UIViewController {

    @IBOutlet weak var Name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var phonenumber: UITextField!
    @IBOutlet weak var DoctorPatient: UISegmentedControl!
    
    @IBAction func Submit(_ sender: Any) {
        var user = PFUser()
        user.username = Name.text
        user.password = password.text
        user.email = email.text
        
        var status = ""
        if DoctorPatient.selectedSegmentIndex == 0 {
            status = "Doctor"
        } else {
            status = "Patient"
        }
        // other fields can be set just like with PFObject
        user["phone"] = phonenumber.text
        user["status"] = status

        user.signUpInBackground {
          (succeeded: Bool, error: Error?) -> Void in
          if let error = error {
            //let errorString = error.userInfo["error"] as? NSString
            // Show the errorString somewhere and let the user try again.
          } else {
            if self.DoctorPatient.selectedSegmentIndex == 0 {
                self.performSegue(withIdentifier: "signupDoctor", sender: self)
            } else {
                self.performSegue(withIdentifier: "signupPatient", sender: self)
            }
          }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()

        // Do any additional setup after loading the view.
    }
}
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
     let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:    #selector(UIViewController.dismissKeyboard))
      tap.cancelsTouchesInView = false
      view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
       view.endEditing(true)
    }
}

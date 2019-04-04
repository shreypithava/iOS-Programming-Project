//
//  LoginViewController.swift
//  Project
//
//  Created by Shrey Pithava on 4/2/19.
//  Copyright © 2019 Shrey Pithava. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var email_Id1: UITextField!
    @IBOutlet weak var password1: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func goPressed(_ sender: UITextField) {

        Auth.auth().signIn(withEmail: email_Id1.text!, password: password1.text!) { (user, error) in
            if error != nil {
                print("Sign in Error")
                print(error!)
            } else {
                print("Login successful")
                self.performSegue(withIdentifier: "loginSuccess", sender: self)
            }
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

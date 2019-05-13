//
//  EmailViewController.swift
//  Project
//
//  Created by Shrey Pithava on 4/2/19.
//  Copyright © 2019 Shrey Pithava. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import SVProgressHUD


class EmailViewController: UIViewController {
    
    @IBOutlet weak var email_Id: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var reTypePassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

    }
    
    @IBAction func goPressed(_ sender: UITextField) {
        SVProgressHUD.show()
//        print(email_Id.text!, password.text!, reTypePassword.text!)
        if password.text! == reTypePassword.text! {
            Auth.auth().createUser(withEmail: email_Id.text!, password: password.text!) { (user, error) in
                if error != nil {
                    print("Registeration error")
                    print(error!)
                    SVProgressHUD.showError(withStatus: "Try Again")
                } else {
                    print("Registeration successful")
                    SVProgressHUD.showSuccess(withStatus: "Registered")
                    self.navigationController?.popToRootViewController(animated: true)
                }
            }
        } else {
            print("Passwords don't match")
            SVProgressHUD.showError(withStatus: "Passwords don't match")
        }
    }

    @IBAction func gestureDone(_ sender: Any) {
        print("Gesture recoginized")
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

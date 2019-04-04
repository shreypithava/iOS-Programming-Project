//
//  EmailViewController.swift
//  Project
//
//  Created by Shrey Pithava on 4/2/19.
//  Copyright © 2019 Shrey Pithava. All rights reserved.
//

import UIKit
import Firebase


class EmailViewController: UIViewController {
    
    @IBOutlet weak var email_Id: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var reTypePassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func goPressed(_ sender: UITextField) {
        print(email_Id.text!, password.text!, reTypePassword.text!)
        if password.text! == reTypePassword.text! {
            Auth.auth().createUser(withEmail: email_Id.text!, password: password.text!) { (user, error) in
                if error != nil {
                    print("Registeration error")
                    print(error!)
                } else {
                    print("Registeration successful")
                }
            }
        } else {
            print("Passwords don't match")
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

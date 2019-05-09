//
//  ControlCenterViewController.swift
//  Project
//
//  Created by Shrey Pithava on 5/8/19.
//  Copyright © 2019 Shrey Pithava. All rights reserved.
//

import UIKit
import Firebase

class ControlCenterViewController: UIViewController {
    
    var defaults = UserDefaults.standard
    var messagesArray = [String]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let items = defaults.array(forKey: "persistantMessages")  as? [String] {
            messagesArray = items
        }
        print(messagesArray)
    }
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
//            performSegue(withIdentifier: "goToRoot", sender: self)
            
            
        } catch  {
            print("Error found during sign out")
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

//
//  GestureViewController.swift
//  Project
//
//  Created by Shrey Pithava on 5/13/19.
//  Copyright © 2019 Shrey Pithava. All rights reserved.
//

import UIKit
import SVProgressHUD

class GestureViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func success(_ sender: Any) {
        SVProgressHUD.showSuccess(withStatus: "Z recognized")
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func successWithI(_ sender: Any) {
        SVProgressHUD.showSuccess(withStatus: "I recognized")
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func successWithV(_ sender: Any) {
        SVProgressHUD.showSuccess(withStatus: "V recognized")
        navigationController?.popToRootViewController(animated: true)
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

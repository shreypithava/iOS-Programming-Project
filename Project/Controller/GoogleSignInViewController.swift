//
//  GoogleSignInViewController.swift
//  Project
//
//  Created by Shrey Pithava on 5/8/19.
//  Copyright © 2019 Shrey Pithava. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class GoogleSignInViewController: UIViewController, GIDSignInUIDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("In ViewDidLoad")
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signIn()
        // Do any additional setup after loading the view.
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        // ...
        print("In SignIn")
        if let error = error {
            print("Error signing in \n\(error)\n")
            return
        }
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        
        Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
            if let error = error {
                print("Error retriving data\n\(error)\n")
                return
            }
            // User is signed in
            print("User Signed In")
            self.performSegue(withIdentifier: "goToControlCenter", sender: self)
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

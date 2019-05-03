//
//  WelcomeViewController.swift
//  Project
//
//  Created by Shrey Pithava on 4/17/19.
//  Copyright © 2019 Shrey Pithava. All rights reserved.
//

import UIKit
import UserNotifications

class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert]) {
            (granted, error) in
            if granted {
                print("yes")
            } else {
                print("No")
            }
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func callNotification(_ sender: Any) {
        let content = UNMutableNotificationContent()
        content.title = "Notification Tutorial"
        content.subtitle = "From ioscreator.com"
        content.body = "Notification triggered"
        
        let imageName = "applelogo"
        if let imageURL = Bundle.main.path(forResource: imageName, ofType: "png") {
            let url = URL(fileURLWithPath: imageURL)
            
            do {
                let attachment = try UNNotificationAttachment(identifier: imageName, url: url, options: nil)
                content.attachments = [attachment]
            } catch {
                print("Attachment was not loaded")
            }
        }
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        let request = UNNotificationRequest(identifier: "notification.id.01", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
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

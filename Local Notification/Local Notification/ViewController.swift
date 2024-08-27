//
//  ViewController.swift
//  Local Notification
//
//  Created by abcd on 22/08/24.
//

import UIKit

class ViewController: UIViewController, UNUserNotificationCenterDelegate {
    @IBOutlet weak var notificationBtn: UIButton!
    let notificationCenter = UNUserNotificationCenter.current()
    override func viewDidLoad() {
        super.viewDidLoad()
        notificationCenter.delegate = self
        notificationCenter.requestAuthorization(options: [.alert, .badge, .sound]) { (success, error) in
            
        }
    }


    @IBAction func notificationAction(_ sender: Any) {
        //content
        let content = UNMutableNotificationContent()
        content.categoryIdentifier = "My Category Identifier"
        content.title = "Local Notification"
        content.body = "This is create example of Local Notification"
        content.badge = 1
        content.sound = UNNotificationSound.default
        content.userInfo = ["name":"Gajanan"]
        //Content Image
        
        let url = Bundle.main.url(forResource: "Lion", withExtension: "jpeg")
        
        let attachment = try! UNNotificationAttachment(identifier: "image", url: url!)
    
        content.attachments = [attachment]
        
        //Trigger time of notification
        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 1, repeats: false) //timimg
        let identifier = "Main Identifier"
        //Notification Request
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        notificationCenter.add(request) { error in
            print(error?.localizedDescription )
        }
        let like = UNNotificationAction(identifier: "Like", title: "Like", options: .foreground)
        let delete = UNNotificationAction(identifier: "Delete", title: "Delete", options: .destructive)
        let category = UNNotificationCategory(identifier: content.categoryIdentifier, actions: [like, delete], intentIdentifiers: [])
        notificationCenter.setNotificationCategories([category])
        
        
        
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification:  UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.list, .banner, .sound, .badge])
        
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let secondVC = self.storyboard?.instantiateViewController(identifier: "SecondViewController") as! SecondViewController
        if let dict = response.notification.request.content.userInfo as? [AnyHashable : Any]{
            secondVC.nameText = dict["name"] as! String
        }
        
        self.navigationController?.pushViewController(secondVC, animated: true)
    }
}


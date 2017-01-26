//
//  NotificationsInterfaceController.swift
//  dailymood
//
//  Created by Adriana Gonzalez on 1/25/17.
//  Copyright © 2017 AMGM. All rights reserved.
//

import WatchKit
import Foundation
import UserNotifications

class NotificationsInterfaceController: WKInterfaceController {

    @IBOutlet var picker: WKInterfacePicker!
    var hours = 1
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        
        var items: [WKPickerItem] = []
        
        for hour in 1...24{
            let pickerItem = WKPickerItem()
            if hour == 1{
                pickerItem.title = "\(hour) hour"
            }else{
                pickerItem.title = "\(hour) hours"
            }
            items.append(pickerItem)
        }
       
        picker.setItems(items)
        
        if let delegate = WKExtension.shared().delegate as? ExtensionDelegate{
            delegate.askForPermission()
        }
    }

    @IBAction func pickerChanged(_ value: Int) {
        print(value)
        hours = value + 1
    }
    
    @IBAction func startTapped() {
        
        for hour in 1...hours{
            let content  = UNMutableNotificationContent()
            content.body = "Log your mood now?"
            content.categoryIdentifier = "moodCategory"
            
            let seconds = 60 * 60 * hour
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(seconds), repeats: false)
            
            let request = UNNotificationRequest(identifier: NSUUID().uuidString, content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) { (error) in
                if error != nil{
                    print("An error occurred")
                }else{
                    print("Success")
                }
            }
        }
        
        UNUserNotificationCenter.current().getPendingNotificationRequests { (requests) in
            print(requests.count)
        }
        
        pop()
    }

    @IBAction func deleteTapped() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().getPendingNotificationRequests { (requests) in
            print(requests.count)
        }
        
        pop()
    }
    
}

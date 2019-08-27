//
//  AppDelegate.swift
//  Scheduling_NotificationLocally
//
//  Created by xdf_yanqing on 2019/5/31.
//  Copyright © 2019 xdf_yanqing. All rights reserved.
//

import Cocoa
import UserNotifications
@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!


    func applicationDidFinishLaunching(_ aNotification: Notification) {
    
     }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func macOS10Noti() -> Void {
        
        let userNotification = NSUserNotification()
        
        userNotification.title = "传统方式"
//        userNotification.subtitle = "old"
//        userNotification.informativeText = "我是一个传统的方式"
//
//        userNotification.hasActionButton = true
//        userNotification.otherButtonTitle = "关闭"
//        userNotification.actionButtonTitle = "显示"
//        let uuidString = UUID().uuidString
//        userNotification.identifier = uuidString
//        userNotification.userInfo = ["method": "old"]
        
//        userNotification.soundName = NSUserNotificationDefaultSoundName
         let date1 = Date(timeIntervalSinceNow: 5)
//        debugPrint(date,date1)
        userNotification.deliveryDate = date1
        
        NSUserNotificationCenter.default.scheduleNotification(userNotification)
        NSUserNotificationCenter.default.delegate = self

        debugPrint(NSUserNotificationCenter.default.scheduledNotifications)
    }
    
    
    
    func testMacOS14() {
        
        //Create the Notification's Content
        if #available(OSX 10.14, *) {
            let content = UNMutableNotificationContent()
            content.title = "课前提醒"
            content.body = "还有5分钟"
            //Specify the Conditions for Delivery
            // Configure the recurring date.
            var dateComponents = DateComponents()
            dateComponents.calendar = Calendar.current
            let date = Date(timeIntervalSinceNow: 20)
            //        dateComponents.weekday = 6  // Tuesday
            //        dateComponents.hour = 18    // 14:00 hours
            //        dateComponents.minute = 13
            // Create the trigger as a repeating event.
            //        let trigger = UNCalendarNotificationTrigger(dateMatching:dateComponents, repeats: true)
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            // Create the request
            let uuidString = UUID().uuidString
            let request = UNNotificationRequest(identifier: uuidString,
                                                content: content, trigger: trigger)
            
            
            
            
            // Define the custom actions.
            let acceptAction = UNNotificationAction(identifier: "ACCEPT_ACTION",
                                                    title: "Accept",
                                                    options: UNNotificationActionOptions(rawValue: 0))
            let declineAction = UNNotificationAction(identifier: "DECLINE_ACTION",
                                                     title: "Decline",
                                                     options: UNNotificationActionOptions(rawValue: 0))
            // Define the notification type
            let meetingInviteCategory =
                UNNotificationCategory(identifier: "MEETING_INVITATION",
                                       actions: [acceptAction, declineAction],
                                       intentIdentifiers: [],
                                       hiddenPreviewsBodyPlaceholder: "",
                                       options: .customDismissAction)
            
            // Schedule the request with the system.
            let notificationCenter = UNUserNotificationCenter.current()
            notificationCenter.setNotificationCategories([meetingInviteCategory])
            notificationCenter.add(request) { (error) in
                if error != nil {
                    // Handle any errors.
                }
            }
            notificationCenter.getPendingNotificationRequests { (items) in
                debugPrint(items)
            }
        } else {
            // Fallback on earlier versions
        }
     

    }
    @IBAction func sendPush(_ sender: NSButton) {
        macOS10Noti()
    }
}

extension AppDelegate : NSUserNotificationCenterDelegate{
    func userNotificationCenter(_ center: NSUserNotificationCenter, shouldPresent notification: NSUserNotification) -> Bool {
        return true
    }
    
    // 推送消息后的回调
    func userNotificationCenter(_ center: NSUserNotificationCenter, didDeliver notification: NSUserNotification) {
        print("\(Date(timeIntervalSinceNow: 0)) -> 消息已经推送")
    }
    
    // 用户点击了通知后的回调
    func userNotificationCenter(_ center: NSUserNotificationCenter, didActivate notification: NSUserNotification) {
        switch notification.activationType {
        case .actionButtonClicked:
            let method = notification.userInfo!["method"] as! String
            print("methods -> \(method)")
        case .contentsClicked:
            print("clicked")
        case .replied:
            print("replied")
        case .additionalActionClicked:
            print("additional action")
        default:
            print("action")
        }
    }
}

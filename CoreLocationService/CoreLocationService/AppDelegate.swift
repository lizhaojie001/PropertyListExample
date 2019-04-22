//
//  AppDelegate.swift
//  CoreLocationService
//
//  Created by xdf_yanqing on 2019/4/18.
//  Copyright © 2019 xdf_yanqing. All rights reserved.
//

import Cocoa
import CoreLocation
@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var mainItem: NSMenuItem!
    @IBOutlet weak var item: NSMenuItem!
    @IBOutlet weak var window: NSWindow!
    lazy var locationMgr: CLLocationManager = {
        let manager = CLLocationManager()
        manager.delegate = self
        return manager
    }()

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        //macOSn不需要requestlocation服务,总是允许的
        mainItem.title = "asdasda"
        if CLLocationManager.locationServicesEnabled() {
        }else{
            debugPrint("没权限")
        }
        locationMgr.startUpdatingLocation()

    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

}

extension AppDelegate : CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        debugPrint(locations)
        locationMgr.stopUpdatingLocation()
     }
    
   
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        debugPrint(error as Any)
        locationMgr.stopUpdatingLocation()
 
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
        case .authorizedAlways:
            print("Location access authorized.")
        case .notDetermined:
            print("Undetermined location access.")
        case .denied:
            print("User denied location access. Exiting.")
         case .restricted:
            print("Location access restricted. Exiting.")
         default:
            break
        }
    }
}

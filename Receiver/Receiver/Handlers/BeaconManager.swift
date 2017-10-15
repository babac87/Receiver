//
//  BeaconManager.swift
//  Receiver
//
//  Created by Mirko Babic on 13/10/2017.
//  Copyright © 2017 Mirko Babic. All rights reserved.
//

import UIKit
import CoreLocation

class BeaconManager: NSObject {
  
  // Singleton
  static let shared = BeaconManager()
  
  // Location manager
  private let manager = CLLocationManager()
    
  // Estimote UUID string
  private let estimoteUUIDString = "B9407F30-F5F8-466E-AFF9-25556B57FE6D"
  
  // Timestamp of last time unlock message was sent
  private var lastTimestamp = 0.0
  
  // Private singleton initializer
  private override init() {
    super.init()
    manager.delegate = self
    manager.requestAlwaysAuthorization()
  }
  
  /// Starts ranging process for iBeacons
  @objc func startRanging() {
    guard locationEndabled() == true else {
      Notifications.lock()
      return
    }
    guard let uuid = UUID(uuidString: estimoteUUIDString) else {
      Notifications.lock()
      return
    }
    let region = CLBeaconRegion(proximityUUID: uuid, identifier: "Estimote")
    manager.startRangingBeacons(in: region)
  }
  
  /// Checks if location is enabled.
  ///
  /// - Returns:
  ///   - false: If location service is unavailable or authorization status is not verified.
  ///   - true: If location is authorized.
  private func locationEndabled() -> Bool {
    guard CLLocationManager.locationServicesEnabled() == true else {
      return false
    }
    switch(CLLocationManager.authorizationStatus()) {
    case .notDetermined, .restricted, .denied:
      return false
    case .authorizedAlways, .authorizedWhenInUse:
      return true
    }
  }
}

extension BeaconManager: CLLocationManagerDelegate {
  
  /// Location manager delegate method implementation. If there are ranged beacons and the first (closest) one is in 50cm range, RESTClient method is called to unlock the door. Otherwise, lock notification is sent.
  func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
    DispatchQueue.main.async {
      let newTimestamp = Date().timeIntervalSince1970
      if newTimestamp - self.lastTimestamp > 4.0 {
        if let beacon = beacons.first, beacon.accuracy < 0.5 && beacon.accuracy > 0.0 {
          RESTClient.unlockDoor()
        } else {
          Notifications.lock()
        }
        self.lastTimestamp = newTimestamp
      }
      print(beacons)
    }
    
  }
  
  /// Location manager delegate method implementation. Starts ranging if status is changed to authorized.
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    switch status {
    case .authorizedAlways, .authorizedWhenInUse:
      startRanging()
    default:
      return
    }
  }
}

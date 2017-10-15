//
//  Notifications.swift
//  Receiver
//
//  Created by Mirko Babic on 15/10/2017.
//  Copyright © 2017 Mirko Babic. All rights reserved.
//

import UIKit

class Notifications: NSObject {
  
  /// Sends notification to NotificationCenter to lock the door
  static func lock() {
    NotificationCenter.default.post(name: NSNotification.Name("Lock"), object: nil)
  }
  
  /// Sends notification to NotificationCenter to unlock the door
  static func unlock() {
    NotificationCenter.default.post(name: NSNotification.Name("Unlock"), object: nil)
  }
}

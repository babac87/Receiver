//
//  RESTClient.swift
//  Receiver
//
//  Created by Mirko Babic on 13/10/2017.
//  Copyright © 2017 Mirko Babic. All rights reserved.
//

import UIKit

class RESTClient: NSObject {
  
  /// URL string for unlocking doors
  static private let urlString = "https://api.getkisi.com/locks/5124/access"
  
  /// Unlocks door if dataTask finishes without an error
  static func unlockDoor() {
    let url = URL(string: urlString)!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.allHTTPHeaderFields =
      ["Content-Type": "application/json",
       "Accept": "application/json",
       "Authorization" : "KISI-LINK 75388d1d1ff0dff6b7b04a7d5162cc6c"]
    let session = URLSession.shared.dataTask(with: request) { (data, response, error) in
      DispatchQueue.main.async {
        if let error = error {
          Notifications.lock()
          print(error.localizedDescription)
        } else {
          Notifications.unlock()
        }
      }
    }
    session.resume()
  }
}

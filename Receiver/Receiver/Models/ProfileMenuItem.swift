//
//  ProfileMenuItem.swift
//  Receiver
//
//  Created by Mirko Babic on 14/10/2017.
//  Copyright © 2017 Mirko Babic. All rights reserved.
//

import UIKit

class ProfileMenuItem: NSObject {
  
  /// Title for item
  private(set) var title: String
  
  /// Image for item
  private(set) var image: UIImage?
  
  /// Accessory type used in tableView
  private(set) var accessoryType: UITableViewCellAccessoryType?
  
  /// Text color used in tableView
  private(set) var textColor: UIColor
  
  /// Initializer
  init(title: String, image: UIImage?, accessoryType: UITableViewCellAccessoryType?, textColor: UIColor = UIColor.black) {
    self.title = title
    self.image = image
    self.accessoryType = accessoryType
    self.textColor = textColor
    super.init()
  }
}

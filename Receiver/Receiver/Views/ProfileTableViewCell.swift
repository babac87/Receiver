//
//  ProfileImageTableViewCell.swift
//  Receiver
//
//  Created by Mirko Babic on 14/10/2017.
//  Copyright © 2017 Mirko Babic. All rights reserved.
//

import UIKit

protocol ProfileTableViewCellDelegate: class {
  /// Delegate method that notifies delegate to change profile image for certain cell
  ///
  /// - Parameters:
  ///     - tableViewCell: Cell that is notifying delegate
  ///     - didPressButton: button that is pressed
  func profileImage(tableViewCell cell: ProfileTableViewCell, didPressButton button: UIButton)
}

class ProfileTableViewCell: UITableViewCell {
  
  /// Delegate for certain cell
  weak var delegate: ProfileTableViewCellDelegate?
  
  /// Profile image of user
  @IBOutlet weak var profileImageView: UIImageView!
  
  /// User name
  @IBOutlet weak var userNameLabel: UILabel!
  
  /// Calls delegate to change image
  ///
  /// - Parameters:
  ///     - sender: Button that triggers image change
  @IBAction func changeImage(_ sender: UIButton) {
    delegate?.profileImage(tableViewCell: self, didPressButton: sender)
  }
}

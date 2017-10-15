//
//  ProfileViewController.swift
//  Receiver
//
//  Created by Mirko Babic on 13/10/2017.
//  Copyright © 2017 Mirko Babic. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
  
  /// Height for profile cell in tableView
  private let profileCellHeight: CGFloat = 155.0
  
  /// Height for other cells in tableView
  private let cellHeight: CGFloat = 44.0
  
  /// Height for header in tableView
  private let headerHeight: CGFloat = 22.0
  
  /// Items for section 0
  private let section0Items =
    [ProfileMenuItem(title: "Name, Phone Numbers, Email",
                     image: nil,
                     accessoryType: .disclosureIndicator),
     ProfileMenuItem(title: "Password & Security",
                     image: nil,
                     accessoryType: .disclosureIndicator),
     ProfileMenuItem(title: "Payment & Shipping",
                     image: nil,
                     accessoryType: .disclosureIndicator)]
  
  /// Items for section 1
  private let section1Items =
    [ProfileMenuItem(title: "iCloud",
                     image: #imageLiteral(resourceName: "icloud"),
                     accessoryType: .disclosureIndicator),
     ProfileMenuItem(title: "iTunes & App Store",
                     image: #imageLiteral(resourceName: "app store"),
                     accessoryType: .disclosureIndicator),
     ProfileMenuItem(title: "Setup Family Sharing...",
                     image: #imageLiteral(resourceName: "sharing"),
                     accessoryType: .none,
                     textColor: UIColor(red: 0, green: 0.5, blue: 1, alpha: 1))]
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
  
  /// TableView dataSource method implementation that returns number of sections
  func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }
  
  /// TableView dataSource method implementation that returns number of rows in section
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch section {
    case 0:
      return 1 + section0Items.count
    case 1:
      return section1Items.count
    default:
      return 0
    }
  }
  
  /// TableView dataSource method implementation that returns cell. If cell is in section 0 and row 0 it returnce ProfileTableViewCell, else it returns default cell
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.section == 0 && indexPath.row == 0 {
      let cell =  tableView.dequeueReusableCell(withIdentifier: "ProfileImageCell") as! ProfileTableViewCell
      cell.delegate = self
      return cell
    } else {
      return cell(forTableView: tableView, indexPath: indexPath)
    }
  }
  
  /// Returns cell for tableView and indexPath
  private func cell(forTableView tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
    let cellReuseIdentifier = "Cell"
    var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier)
    if (cell == nil) {
      cell = UITableViewCell(style:UITableViewCellStyle.subtitle, reuseIdentifier:cellReuseIdentifier)
    }
    let profileMenuItem: ProfileMenuItem
    if indexPath.section == 0 {
      profileMenuItem = section0Items[indexPath.row - 1]
    } else {
      profileMenuItem = section1Items[indexPath.row]
    }
    cell?.textLabel?.text = profileMenuItem.title
    cell?.textLabel?.textColor = profileMenuItem.textColor
    cell?.imageView?.image = profileMenuItem.image
    if let accessoryType = profileMenuItem.accessoryType {
      cell?.accessoryType = accessoryType
    }
    return cell!
  }
  
  /// TableView delegate method implementation that responds to selection
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if indexPath.section == 0 && indexPath.row == 0 {
      return
    } else {
      print("This should lead to next ViewController")
    }
  }
  
  /// TableView delegate method implementation that returns height of a cell.
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.section == 0 && indexPath.row == 0 {
      return profileCellHeight
    } else {
      return cellHeight
    }
  }
  
  /// TableView delegate method implementation that returns height of a header.
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return headerHeight
  }
}

extension ProfileViewController: ProfileTableViewCellDelegate {
  /// ProfileTableViewCell delegate method implementation that responds on user pressing the profile image in first cell.
  func profileImage(tableViewCell cell: ProfileTableViewCell, didPressButton button: UIButton) {
    print("You can change your profile image in here")
  }
}

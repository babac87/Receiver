//
//  MainViewController.swift
//  Receiver
//
//  Created by Mirko Babic on 13/10/2017.
//  Copyright © 2017 Mirko Babic. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
  
  /// Lock state
  private enum Lock {
    case locked
    case unlocked
  }
  
  /// State of the door
  private var lock = Lock.locked

  /// Image that represent current state of the door
  @IBOutlet weak var lockImageView: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    addObeservers()
  }
  
  /// Adds observers to MainViewController
  private func addObeservers() {
    NotificationCenter.default.addObserver(self, selector: #selector(MainViewController.lockDoor), name: NSNotification.Name("Lock"), object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(MainViewController.unlockDoor), name: NSNotification.Name("Unlock"), object: nil)
  }
  
  /// Changes image to unlocked lock and state to unlocked
  @objc func unlockDoor() {
    lock(.unlocked, image: #imageLiteral(resourceName: "unlock"))
  }
  
  /// Changes image to locked lock and state to locked
  @objc func lockDoor() {
    lock(.locked, image: #imageLiteral(resourceName: "lock"))
  }
  
  private func lock(_ lock : Lock, image: UIImage) {
    if self.lock == lock {
      return
    }
    let newLockImageView = UIImageView(image: image)
    newLockImageView.frame = self.lockImageView.frame
    UIView.transition(from: self.lockImageView, to: newLockImageView, duration: 1, options: .transitionCrossDissolve, completion: { _ in
      self.lockImageView = newLockImageView
    })
    self.lock = lock
  }
}


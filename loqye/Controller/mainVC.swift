//
//  ViewController.swift
//  loqye
//
//  Created by youssef on 12/5/18.
//  Copyright © 2018 youssef. All rights reserved.
//

import UIKit
import UserNotifications
class mainVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        }
    

}
extension UITabBarController {
    @IBInspectable var selected_index: Int {
        get {
            return selectedIndex
        }
        set(index) {
            selectedIndex = index
        }
    }
}



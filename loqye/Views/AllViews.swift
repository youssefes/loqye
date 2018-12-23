//
//  AllViews.swift
//  loqye
//
//  Created by youssef on 12/18/18.
//  Copyright © 2018 youssef. All rights reserved.
//

import UIKit

class textFiled : UITextField{
    
    @IBInspectable var corner_Reduis : CGFloat = 0.0 {
        didSet{
            layer.cornerRadius = corner_Reduis
        }
    }

}

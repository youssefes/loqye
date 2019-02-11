//
//  circilImage.swift
//  loqye
//
//  Created by youssef on 1/3/19.
//  Copyright © 2019 youssef. All rights reserved.
//

import UIKit
@IBDesignable
class ImageCuircl : UIImageView{
    @IBInspectable var corner_Reduis : CGFloat = 0.0 {
        didSet{
            layer.cornerRadius = corner_Reduis
        }
    }
    
}


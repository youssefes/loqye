//
//  btnView.swift
//  loqye
//
//  Created by youssef on 12/7/18.
//  Copyright © 2018 youssef. All rights reserved.
//

import UIKit

class btnView: UIButton {

    @IBInspectable var corner_Reduis : CGFloat = 0.0 {
        didSet{
            layer.cornerRadius = corner_Reduis
        }
    }
    
    @IBInspectable var border_Width : CGFloat = 0.0{
        didSet{
            layer.borderWidth = border_Width
        }
    }
    @IBInspectable var border_color : UIColor = .black{
        didSet{
            layer.borderColor = border_color.cgColor
        }
    }    
    @IBInspectable var PadingleftImage : CGFloat = 0.0 {
        didSet{
            imageEdgeInsets.left = PadingleftImage
        }
    }
    @IBInspectable var padindRightImage : CGFloat = 0.0 {
        didSet{
            imageEdgeInsets.right = padindRightImage
        }
        
    }
   
    @IBInspectable var PadingBottomImage : CGFloat = 0.0 {
        didSet{
            imageEdgeInsets.bottom = PadingBottomImage
        }
    }
    @IBInspectable var PadingTopImage : CGFloat = 0.0 {
        didSet{
            imageEdgeInsets.top = PadingTopImage
        }
    }
    
    @IBInspectable var titleLeftPadding: CGFloat = 0.0 {
        didSet {
            titleEdgeInsets.left = titleLeftPadding
        }
    }
    @IBInspectable var titleRightPadding: CGFloat = 0.0 {
        didSet {
            titleEdgeInsets.right = titleRightPadding
        }
    }
    @IBInspectable var titleTopPadding: CGFloat = 0.0 {
        didSet {
            titleEdgeInsets.top = titleTopPadding
        }
    }
    @IBInspectable var titleBottomPadding: CGFloat = 0.0 {
        didSet {
            titleEdgeInsets.bottom = titleBottomPadding
        }
    }
    

}

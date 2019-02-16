//
//  addImageAndPading.swift
//  loqye
//
//  Created by youssef on 12/27/18.
//  Copyright © 2018 youssef. All rights reserved.
//

import UIKit
@IBDesignable
class addImageAndPading: UITextField {

    @IBInspectable var imageRight : UIImage?{
        didSet{
            guard  let image = imageRight else {
                return
            }
               let imageWidth = (imageRight?.size.width)!
               let imageHight = (imageRight?.size.height)!
               let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: imageWidth , height: imageHight ))
                imageView.image = image
               let view = UIView(frame: CGRect(x:0, y: 0, width: imageWidth + 10, height: imageHight ))
                print(imageWidth)
                view.addSubview(imageView)
                self.rightView = view
                self.rightViewMode = .always
            
        }
        
    }
    

}

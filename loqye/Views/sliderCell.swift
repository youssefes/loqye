//
//  sliderCell.swift
//  loqye
//
//  Created by youssef on 1/26/19.
//  Copyright © 2019 youssef. All rights reserved.
//

import UIKit

class sliderCell: UICollectionViewCell {
    
    @IBOutlet weak var sliderimage: UIImageView!
    
    var image : UIImage!{
        didSet{
            sliderimage.image = image
        }
    }
}

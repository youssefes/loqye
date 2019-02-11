//
//  searchByHell.swift
//  loqye
//
//  Created by youssef on 12/18/18.
//  Copyright © 2018 youssef. All rights reserved.
//

import UIKit

class searchByHell: UIViewController {

    var textFiledText = ""
    var allData = [dataByName]()
    
    @IBOutlet weak public var txtField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
   
    
   
    @IBAction func btnShowSearchByData(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnSearchByName(_ sender: Any) {
        guard let text = txtField.text, !text.isEmpty else {
            return
        }
        textFiledText = text
        performSegue(withIdentifier: "showResult", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! searchResult
        vc.text = self.textFiledText
    }
    
  
    
    
/*extension UITextField{
    
    func addImageTxtField(image : UIImage ){
        let rightImageView = UIImageView(frame: CGRect(x: 0 , y: 0, width: image.size.width, height: image.size.height))
        rightImageView.image = image
        
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: image.size.width + 10, height: image.size.width))
        view.addSubview(rightImageView)
        
        self.rightView = view
        self.rightViewMode = .always
    }
 */
    
    
}

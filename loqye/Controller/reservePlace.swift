//
//  reservePlace.swift
//  loqye
//
//  Created by youssef on 2/1/19.
//  Copyright © 2019 youssef. All rights reserved.
//

import UIKit
import Firebase

class reservePlace: UIViewController {

    @IBOutlet weak var endDate: UITextField!
    @IBOutlet weak var startDate: UITextField!
    @IBOutlet weak var phonetxt: UITextField!
    @IBOutlet weak var nametxt: UITextField!
    var id = 0
    var allDataPlace : placeDetails?
    override func viewDidLoad() {
        super.viewDidLoad()
       print(id)
        navigationItem.title = "احجز الان"
        
    }
    func rservseHnandel() {
        guard let uid = Auth.auth().currentUser?.uid else{
            return
        }
        guard let name = nametxt.text, !name.isEmpty, let phone = phonetxt.text,!phone.isEmpty,let start = startDate.text, !start.isEmpty,let end = endDate.text ,!end.isEmpty else {
            return
        }
        
        API.reservePlace(name: name, phone: phone, start_date: start, place_id: self.id, end_date: end, firebaseToken: uid) { (success:Bool, message:String?) in
            
            if success{
                guard let message = message else{
                    return
                }

                let alert = UIAlertController(title: "success", message: message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (UIAlertAction) in
                    
                }))
                self.present(alert, animated: true, completion: nil)
        
                self.endDate.text = ""
                self.startDate.text = ""
                self.phonetxt.text = ""
                self.nametxt.text = ""
            
                
            }
        }
    
    }
    
    @IBAction func reserveNewbtn(_ sender: Any) {
        rservseHnandel()
    }
}

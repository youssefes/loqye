//
//  createEmailToReservation.swift
//  loqye
//
//  Created by youssef on 2/13/19.
//  Copyright © 2019 youssef. All rights reserved.
//

import UIKit
import Firebase

class createEmailToReservation: UIViewController {

    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    
    @IBAction func login(_ sender: Any) {
        guard let email = email.text ,!email.isEmpty, let password = password.text else{
            return
        }
        
        creatEmail(email: email, password: password)
        
    }
    func creatEmail(email:String, password: String){
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
            if let error = error {
                print(error)
            }else{
                self.performSegue(withIdentifier: "logindone", sender: nil)
            }
            
        })
    }

   
}

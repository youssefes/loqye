//
//  contectUS.swift
//  loqye
//
//  Created by youssef on 1/25/19.
//  Copyright © 2019 youssef. All rights reserved.
//

import UIKit

class contectUS: UIViewController {

    @IBOutlet weak var txtName: UITextField!
    
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txtmasaage: UITextField!
    
    @IBOutlet weak var txtPhone: UITextField!
    
    @IBOutlet weak var emailLBL: UILabel!
    @IBOutlet weak var phoneLBL: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        handelDataContacts()
    }
    
    func handelDataContacts() {
        API.Our_contects { (success:Bool, contacts:[contacts]?) in
            if success {
                guard let contact = contacts else{
                    return
                }
                self.phoneLBL.text = contact[0].phone
                self.emailLBL.text = contact[0].email
            }
        }
    }
    @IBAction func backbtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sendDatabtn(_ sender: Any) {
        guard let email = txtEmail.text, !email.isEmpty, let phone = txtPhone.text , !phone.isEmpty, let massage = txtmasaage.text , !massage.isEmpty, let name = txtName.text , !name.isEmpty, let title = txtTitle.text, !title.isEmpty else{
            return
        }
        
        API.contectUS(name: name, title: title, phone: phone, massage: massage, email: email) { (succes:Bool, massage:String?) in
            if succes{
                guard let massageData = massage else{
                    return
                }
                
                let alert = UIAlertController(title: "Success", message: massageData, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
                self.txtTitle.text = ""
                self.txtName.text = ""
                self.txtmasaage.text = ""
                self.txtPhone.text = ""
                self.txtEmail.text = ""
                
            }
        }
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

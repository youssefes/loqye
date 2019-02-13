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
                
                self.saveDataInDatabase(stratDate: "\(start)", endDate: "\(end)")
                let alert = UIAlertController(title: "success", message: message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (UIAlertAction) in
                    
                }))
                self.present(alert, animated: true, completion: nil)
        
            }
        }
    
    }
    

    
    func saveDataInDatabase(stratDate: String, endDate :String)  {
        guard let UId = Auth.auth().currentUser?.uid else{
            return
        }
        
        guard let allDataPlaces = allDataPlace else {
            return
        }
        let refData = Database.database().reference()
        let userRefrence = refData.child("user_Reservation").child(UId).child(allDataPlaces.title)
       
        guard let value = ["start_Date" : startDate, "end_Date" : endDate, "id" : allDataPlaces.id , "rating" : allDataPlaces.rating , "preis" : allDataPlaces.price, "title" : allDataPlaces.title] as? [String : AnyClass] else {
            return
        }
        userRefrence.updateChildValues(value) { (error, databaseRe) in
            if let erro = error{
                print(erro)
            }else{
                
            }
        }
        
    }
    
    @IBAction func reserveNewbtn(_ sender: Any) {
        rservseHnandel()
    }
}

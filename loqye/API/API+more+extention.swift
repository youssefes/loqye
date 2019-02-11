//
//  API+more+extention.swift
//  loqye
//
//  Created by youssef on 1/25/19.
//  Copyright © 2019 youssef. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
extension API{
    
    class func reservePlace(name: String,phone: String, start_date :String, place_id : Int , end_date : String,firebaseToken:String, complation:@escaping (_ success:Bool,_ massage : String?)->Void){
        
        let parameters : Parameters = [
            "place_id" : place_id,
            "phone" : phone,
            "start_date" : start_date,
            "end_date" : end_date,
            "firebase_token" : firebaseToken,
            "name" : name
        ]
        
        Alamofire.request(RESERVE, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).validate(statusCode: 200..<300).responseJSON { (respond) in
            switch respond.result{
            case .failure(let error):
                print(error)
                complation(false,nil)
            case .success(let value):
                let json = JSON(value)
                guard let massage = json["message"].string else {
                    return
                }
                complation(true, massage)
            }
        }
    }
    
    /// contect Us
    
    class func contectUS(name: String, title: String, phone:String, massage: String, email: String, complation : @escaping (_ success: Bool , _ massage : String?)->Void){
        
        let parameters : [String: Any ] = [
            "name":name,
            "phone" : phone,
            "email": email,
            "title" : title,
            "message" : massage
        ]
        
        Alamofire.request(CONTECTUS, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).validate(statusCode: 200..<300).responseJSON { (respond) in
            switch respond.result{
            case .failure(let error):
                print(error)
                complation(false, nil)
            case .success(let value):
                let json = JSON(value)
                guard let data = json.dictionary else{
                    return
                }
                guard let massagedata = data["message"]?.stringValue else{
                    return
                }
                complation(true, massagedata)
                
            }
        }
    }
    
    
    /// get Customer openine
    
    class func customerOpenin(complation : @escaping (_ success: Bool, _ openines: [openine]?)->Void){
        
        
        Alamofire.request(OPENINE).validate(statusCode: 200..<300).responseJSON { (respond) in
            switch respond.result{
            case .failure(let error):
                print(error)
                complation(false, nil)
            case .success(let Value):
                let json = JSON(Value)
                guard let alldata = json["data"].array else{
                    return
                }
                var allopenine = [openine]()
                for data in alldata{
                    guard let opdata = data.dictionary else{
                        return
                    }
                    
                    guard let name = opdata["name"]?.stringValue else{
                        return
                    }
                    guard let opinioneData = opdata["opinion"]?.stringValue else{
                        return
                    }
                    
                    let oneOpeni = openine(name: name, openines: opinioneData)
                    allopenine.append(oneOpeni)
                }
                complation(true, allopenine)
            }
        }
    }
    
    
    class func getFaq(complation : @escaping (_ success : Bool,_ datafaq : [Datafaq]?)-> Void){
        
        
        Alamofire.request(FAQURL).responseJSON { (respond) in
            switch respond.result{
                
            case .failure(let error):
                complation(false,nil)
                print(error)
            case .success(let value):
                let json = JSON(value)
                guard let Alldata = json["data"].array else{
                    return
                }
                var arrayData = [Datafaq]()
                for data in Alldata {
                    guard let dataValue = data.dictionary else {
                        return
                    }
                    
                    guard let title = dataValue["title"]?.stringValue else{
                        return
                    }
                    guard let dateils = dataValue["details"]?.stringValue else {
                        return
                    }
                    
                    let dataF = Datafaq.init(title: title, details: dateils)
                    print(dataF)
                    arrayData.append(dataF)
                }
                complation(true, arrayData)
            }
        }
        
    }
    
    /// Our contacts
    
    class func Our_contects (complation : @escaping (_ success : Bool,_ datafaq: [contacts]?)-> Void){
        
        Alamofire.request(OUR_CONTACTS).responseJSON { (respond) in
            switch respond.result{
            
            case .failure(let error):
                print(error)
                complation(false, nil)
            case .success(let value):
                let json = JSON(value)
                
                guard let allData = json["data"].array else{
                    return
                }
                var ArrayData = [contacts]()
                for data in allData {
                    guard let email = data["email"].string, let phone = data["phone"].string, let mobile = data["mobile"].string, let fax = data["fax"].string else {
                        return
                    }
                    
                    let dataValue = contacts(email: email, mobeil: mobile, phone: phone, fax: fax)
                    ArrayData.append(dataValue)
                }
                print("the contacts is \(ArrayData)")
                
                complation(true, ArrayData)
            }
            
        }
    }
}


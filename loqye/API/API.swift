//
//  API.swift
//  loqye
//
//  Created by youssef on 12/21/18.
//  Copyright © 2018 youssef. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class API: NSObject {
    
    // to search by place_name
    
    class func search_By_place(name : String, complation: @escaping complationHandler){
        
        let parameteres : [String: String] = [
            "q" : name
        ]
        
        Alamofire.request(SEARCH_BY_PLACE, method: .post, parameters: parameteres, encoding: JSONEncoding.default, headers: nil).validate(statusCode: 200..<300).responseJSON { (respond) in
            switch respond.result{
            case .failure(let error):
                complation(false)
                print(error)
            case .success(let value):
                let data = JSON(value)
                complation(true)
                print(data)
                print(data["state"].stringValue)
            }
        }
        
    }
    
    
    // to get departments
    
    class func department(complation:@escaping complationHandler){
        
        Alamofire.request(DEPARTMENT, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).validate(statusCode: 200..<300).responseJSON { (respond) in
            switch respond.result{
            case .failure(let error):
                print(error)
                complation(false)
            case .success(let value):
                
                let data = JSON(value)
                
                complation(true)
                print(data)
                print(data["state"].stringValue)
            }
        }
    }
    
    
    
    //to Get all places
    class func getAllPlaces(depart_id : Int, complatin: @escaping complationHandler){
        
        let parameters : [String:Int] = [
        "dept_id": depart_id
        ]
        
        Alamofire.request(PLACES, method: .get, parameters: parameters, encoding: JSONEncoding.default, headers: nil).validate(statusCode: 200..<300).responseJSON { (respond) in
            switch respond.result{
            case .failure(let error):
                complatin(false)
                print(error)
            case .success(let value):
                let data = JSON(value)
                complatin(true)
                print(data)
                print(data["state"].stringValue)
            }
        }
    }
    
    // to get place details
    
    class func show_Place_Details(place_id : Int, complation:@escaping complationHandler){
        
        let paramerters:[String:Int] = [
        
            "place_id":place_id
        ]
        
        Alamofire.request(PLACE_DETAILS, method: .get, parameters: paramerters, encoding: JSONEncoding.default, headers: nil).validate(statusCode: 200..<300).responseJSON { (respond) in
            switch respond.result{
            case .failure(let error):
                print(error)
                complation(false)
            case.success(let value):
                let data = JSON(value)
                print(data)
                complation(true)
            }
        }
    }
    
    

}

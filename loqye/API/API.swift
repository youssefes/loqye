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
    
    
    
    /// to search by place_name
    
    class func search_By_place(name : String, complation: @escaping (_ success : Bool, _ data_from_search:[dataByName]?)->Void){
        
         var array_of_data = [dataByName]()
        
        let parameteres : [String: String] = [
            "q" : name
        ]
        
        Alamofire.request(SEARCH_BY_PLACE, method: .post, parameters: parameteres, encoding: JSONEncoding.default, headers: nil).validate(statusCode: 200..<300).responseJSON { (respond) in
            switch respond.result{
            case .failure(let error):
                complation(false,nil)
                print(error)
            case .success(let value):
                let data = JSON(value)
               
               
                if let databyname = data["data"].array{
                    
                    if databyname.isEmpty{
                        complation(true,array_of_data)
                    }
                    else{
                        for datasearch in databyname{
                            guard let datafromarr = datasearch.dictionary else{
                                return
                            }
                            guard let id = datafromarr["id"]?.int,  let title = datafromarr["title"]?.string, let image = datafromarr["image"]?.string,let imagePath = datafromarr["imagesPath"]?.string
                                else
                            {
                                
                                return
                            }
                            print(title,id, image, imagePath)
                            get_Image(imagePath: imagePath, imageUrl: image, complation: { (image:UIImage?) in
                                
                                let alldata_search = dataByName(title: title, id: id, image: image! )
                                array_of_data.append(alldata_search)
                                complation(true, array_of_data)
                            })
                        }
                    }
                    
                }else{
                    complation(false,nil)
                }
            }
        }
        
    }
    
    
    /// to get departments
    
    class func department(complation:@escaping (_ error : Error? , [Departs]?)->Void){
   
        Alamofire.request(DEPARTMENT, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).validate(statusCode: 200..<300).responseJSON { (respond) in
            switch respond.result{
            case .failure(let error):
                print(error)
                complation(error, nil)
            case .success(let value):
                var data_departs = [Departs]()
                let Alldata = JSON(value)
                guard let departs_Data = Alldata["data"].array else{
                    complation(nil,nil)
                    return
                }
                
                for depart in departs_Data{
                    guard let departs = depart.dictionary else{
                        return
                    }
                    let name = departs["name"]?.string ?? ""
                    let id = departs["id"]?.int ?? 0
                    let veluesData =  Departs(name: name, id: id)
                    data_departs.append(veluesData)
                }
                
                complation(nil, data_departs)
                
 
            }
        }
    }
    
    /// get place details
    
    class func get_Place_by_id(places_id: Int, complation : @escaping (_ succes: Bool, _ data : placeDetails?)-> Void){
        
        guard  let url = URL(string: "https://luqia.net/api/places/show/\(places_id)") else{
            return
        }

        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).validate(statusCode: 200..<300).responseJSON { (respond) in
            switch respond.result{
            case .failure(let error):
                print("error get place \(error)")
                complation(false, nil)
            case .success(let value):
                let json = JSON(value)
                
                guard let allplaces = json.dictionary else{
                    return
                }
                
                guard let place = allplaces["data"]?.dictionary else{
                    return
                }
                    
                    
                    let name = place["title"]?.stringValue ?? ""
                print(name)
                     let id = place["id"]?.int ?? 0
                        
                    
                    let rating = place["rating"]?.int ?? 0
                    guard let imagepath = place["imagesPath"]?.stringValue else{
                            return
                        }
                    guard let imagename = place["image"]?.stringValue else{
                            return
                        }
                    guard let detailes = place["details"]?.stringValue else {
                        return
                    }
                    let price = place["price"]?.int ?? 0
            
                    
                    let area = place["area"]?.stringValue ?? ""
                    let availiable = place["availiable"]?.stringValue ?? ""
                       
                    let rooms = place["rooms"]?.stringValue ?? ""
                    print(rooms)
                   let workers = place["workers"]?.stringValue ?? ""
                    print(workers)
                    let address = place["address"]?.stringValue ?? ""
                    
                    let chairs = place["chairs"]?.stringValue ?? ""
                print(chairs)
                    guard let images = place["images"]?.array else{
                        return
                    }
                    var imaggess = [String]()
                    for imageess in images{
                        let image = "\(imageess["image"].stringValue)"
                        let imageURL = imagepath+image
                        imaggess.append(imageURL)
                        print(imaggess)
                }
                    API.get_Image(imagePath: imagepath, imageUrl: imagename, complation: { (imagePlace:UIImage?) in
                        guard let imageNameplace = imagePlace else{
                            return
                        }
                        
                          let placeData = placeDetails(id: id, title: name, details: detailes, price: price, area: area, availiable: availiable, rooms: rooms, workers: workers, address: address, chairs: chairs, rating: rating, image: imageNameplace , images : imaggess )
                        
                        
                        complation(true, placeData)
                    })
                
                
            }
        }
        
    }

    /// to get all places
    
    class func get_all_Places(place_id : Int, complation : @escaping (_ seccess :Bool, _ data: [places_data]?)->Void){
        
        guard let URlPlaces = URL(string: "https://luqia.net/api/places/\(place_id)") else {
            return
        }
        Alamofire.request(URlPlaces, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).validate(statusCode: 200..<300).responseJSON { (respond) in
            
            switch respond.result{
                
            case .failure(let error):
                print(error)
                complation(false, nil)
            case.success(let value):
                var arrPlace = [places_data]()
                let json = JSON(value)
                print(json)
                guard let allPlaces = json["data"].array else {
                    return
                }
                print(allPlaces)
                if allPlaces.count == 0 {
                    complation(true,arrPlace)
                }
                if allPlaces.count > 0 {
                    for places in allPlaces{
                        guard let place = places.dictionary else{
                            return
                        }
                        guard let image = place["image"]?.stringValue else{
                            return
                        }
                        guard let imagePaths = place["imagesPath"]?.stringValue else{
                            return
                        }
                        
                        self.get_Image(imagePath: imagePaths, imageUrl: image, complation: { (image:UIImage?) in
                            
                            guard let images = image else{
                                return
                            }
                            guard let id = place["id"]?.int else{
                                return
                            }
                            guard let rating = place["rating"]?.int else{
                                return
                            }
                            guard let name = place["title"]?.stringValue else {
                                return
                            }
                            let data = places_data(id: id, title: name, rating: rating, image: images)
                            arrPlace.append(data)
                            complation(true, arrPlace)
                            
                        })
                        
                    }
                }
            }
            
        }
    }
    
    /// get all offers
    class func show_offer(complation:@escaping (_ success : Bool, _
        DataOffer:[OffersData]?)->Void){
        
        Alamofire.request(OFFERS).responseJSON { (respond) in
            switch respond.result{
            case .failure(let error):
                print(error)
                complation(false,nil)
            case .success(let value):
                let json = JSON(value)
                var array_Of_Offers = [OffersData]()
                guard let dataar = json["data"].array else{
                    return
                }
                for offerdata in dataar{
                    
                    guard var allDataDic = offerdata.dictionary else{
                        complation(false,nil)
                        return
                    }
                    
                    let place_id = allDataDic["place_id"]?.int ?? 0
                    let imagePath = allDataDic["imagesPath"]?.string ?? ""
                    let percentage = allDataDic["percentage"]?.string ?? ""
                    guard let place = allDataDic["place"]?.dictionary else{
                        return
                    }
                    
                    let title = place["title"]?.string ?? ""
                    let image = place["image"]?.string ?? ""
                    let id = place["id"]?.int ?? 0
                    let price = place["price"]?.int ?? 0
                    let rating = place["rating"]?.int ?? 0
                    let price_after_discount = place["price_after_discount"]?.int ?? 0
                    self.get_Image(imagePath: imagePath, imageUrl: image, complation: { (imageu :UIImage?) in
                        let putDataInStruct = OffersData(place_id: place_id, precentage: percentage, id: id, title: title, image: imageu!, rating: rating, price: price, price_after_discount: price_after_discount)
                        array_Of_Offers.append(putDataInStruct)
                        complation(true, array_Of_Offers)
                    })
                }
        }
        
    }
}
    /// downlaod images
    class func get_Image(imagePath : String ,imageUrl : String, complation:@escaping ( _ image : UIImage?)->Void){
        /*
        // using URlSession
        let urlImage = URL(string: "\(MAIN_URL)\(imageUrl)")
        URLSession.shared.dataTask(with: urlImage!) { (image_data, respeaned, error) in
            if let error = error{
                print("the error is  \(error)")
                complation(nil)
            }
            if let respond = respeaned as? HTTPURLResponse{
                if respond.statusCode == 200{
                    let image = UIImage(data: image_data!)
                    complation(image)
                }
            }
        }
        */
        //using alamofire to download image with link
       
        let urlImageA = "\(imagePath)\(imageUrl)"
        print(urlImageA)
        Alamofire.request(urlImageA).response { (respond) in
            if let data = respond.data , let image = UIImage(data: data){
                complation(image)
            }
        }
        
    }
    
   
    
    

}

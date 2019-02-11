//
//  Home.swift
//  loqye
//
//  Created by youssef on 12/18/18.
//  Copyright © 2018 youssef. All rights reserved.
//

import UIKit

class Home: UIViewController {

    @IBOutlet weak var btnDepartname2: btnView!
    @IBOutlet weak var btnDepartName1: btnView!
    var id1 = 0
    var id2 = 0
    var spanner : UIActivityIndicatorView?
     var screnSize = UIScreen.main.bounds
    var allPlaces = [Departs]()
    var count = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addspanner()
        handeledData()
    }
    func addspanner() {
        spanner = UIActivityIndicatorView()
        spanner?.center = CGPoint( x: (screnSize.width/2) - ((spanner?.frame.width)!/2), y: screnSize.height/2)
        spanner?.style = .whiteLarge
        spanner?.color = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        spanner?.startAnimating()
        view.addSubview(spanner!)
    }
    
    func removerspanner(){
        if spanner != nil{
            spanner?.removeFromSuperview()
        }
    }
   
        
    func handeledData(){
        
        API.department { (error:Error?, departments:[Departs]?) in
            
            guard let departs = departments else {
                return
            }
            
            for department in departs{
                if self.count == 0{
                    self.btnDepartName1.setTitle(department.name, for: .normal)
                    self.id1 = department.id
                    
                    self.count += 1
                    self.btnDepartName1.isHidden = false
                }
                else{
                    self.btnDepartname2.setTitle(department.name, for: .normal)
                    self.btnDepartname2.isHidden = false
                   self.id2 = department.id
                }
                
                self.allPlaces.append(department)
                
            }
            print("done")
            self.removerspanner()
            
        }
    }
    
    @IBAction func pressbtn2(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "allPlaceesVC") as? allPlaceesVC
        vc?.id_Place = self.id2
         self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    @IBAction func pressbtn1(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "allPlaceesVC") as? allPlaceesVC
        vc?.id_Place = self.id1
         self.navigationController?.pushViewController(vc!, animated: true)
    }
    
}


//
//  my_Reservations.swift
//  loqye
//
//  Created by youssef on 2/11/19.
//  Copyright © 2019 youssef. All rights reserved.
//

import UIKit
import Firebase
import Cosmos
import TinyConstraints
import Kingfisher
class my_Reservations: UIViewController {
    
    var allReservationData = [my_reservationModel]()
    @IBOutlet weak var collectionViewReservation: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionViewReservation.dataSource = self
        collectionViewReservation.delegate = self
        handelReservationData()
        // Do any additional setup after loading the view.
    }
    
    func handelReservationData(){
        
        
    /// Using my firebase
        
        
        
        
/// using API fireBase of Loqya
        
        
//        API.get_MyReservations(token: "0x6000021736c0") { (success:Bool, allData:[my_reservationModel]?) in
//            if success{
//                guard let reservationData = allData else {
//                    return
//                }
//                self.allReservationData = reservationData
//
//                DispatchQueue.main.async(execute: {
//                    self.collectionViewReservation.reloadData()
//
//                })
//
//
//}
//}
    }
    // create view of cosmon Rating
    fileprivate func cosmonView (retaing : Double ) -> CosmosView {
        var cosmosView : CosmosView{
            let view = CosmosView()
            view.settings.fillMode = .half
            view.settings.updateOnTouch = false
            view.rating = retaing
            return view
        }
        return cosmosView
    }
    
       
}

extension my_Reservations : UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allReservationData.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "my-reservationcell", for: indexPath) as? my_reservationCell {
            
            let view = cosmonView(retaing: Double(allReservationData[indexPath.row].rating))
            cell.ratingView.addSubview(view)
            view.centerInSuperview()
            
            cell.nameLbl.text = allReservationData[indexPath.row].title
            cell.endDateLbl.text = allReservationData[indexPath.row].endDate
            cell.startDetalbl.text = allReservationData[indexPath.row].startDate
            //this is with loqy api let ImagePath = allReservationData[indexPath.row].imagePath
            let imageName = allReservationData[indexPath.row].image
            
            //this is with loqy api  let UrlImage = URL(string: "\(ImagePath)\(imageName)")
                 cell.imagePlace.kf.setImage(with: URL(string: "hjkk"))
            cell.priceLbl.text = "\(allReservationData[indexPath.row].price)"
            
            
            
            return cell
        }else{
            return UICollectionViewCell()
        }
        
    }
}

extension my_Reservations : UICollectionViewDelegate{
    
}

//
//  allPlacesVC.swift
//  loqye
//
//  Created by youssef on 1/21/19.
//  Copyright © 2019 youssef. All rights reserved.
//

import UIKit
import Cosmos
import TinyConstraints

class allPlacessVC: UIViewController {
    var id_Place = 0
    var name = ""
    
    @IBOutlet weak var noDataLbl: UILabel!
    
    var spanner : UIActivityIndicatorView?
    var screnSize = UIScreen.main.bounds
    var id_places = [places_data]()
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
    
    @IBOutlet weak var collectionViewPlaces: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewPlaces.dataSource = self
        collectionViewPlaces.delegate = self
        addspanner()
        handelData(id:id_Place )
        title = name
        

         
        // Do any additional setup after loading the view.
    }
    
    func handelData(id :Int){
        
        API.get_all_Places(place_id: id ) { (sucsse:Bool, data:[places_data]?) in
            if sucsse{
                guard let datapl = data else {
                    return
                }
                if datapl.count == 0{
                    print("\(datapl) no datas")
                    self.collectionViewPlaces.isHidden = true
                   self.noDataLbl.isHidden = false
                    
                     self.removerspanner()
                    
                }else{
                    self.noDataLbl.isEnabled = true
                    self.id_places = datapl
                    self.collectionViewPlaces.reloadData()
                    self.removerspanner()
                }
                
            }
            else{
                self.removerspanner()
                let alert = UIAlertController(title: "error", message: "therr is some problem with conection", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                
                
            }
        }
        
    }
    func addspanner() {
        spanner = UIActivityIndicatorView()
        spanner?.center = CGPoint( x: (screnSize.width/2) - ((spanner?.frame.width)!/2), y: screnSize.height/2)
        spanner?.style = .whiteLarge
        spanner?.color = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        spanner?.startAnimating()
        collectionViewPlaces.addSubview(spanner!)
    }
    func removerspanner(){
        if spanner != nil{
            spanner?.removeFromSuperview()
        }
    }
}
extension allPlacessVC : UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return id_places.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "all_placess", for: indexPath) as! allPlacesCell
        
        cell.namePlace.text = id_places[indexPath.row].title
        cell.imagePlace.image = id_places[indexPath.row].image
        let view = cosmonView(retaing: Double(id_places[indexPath.row].rating))
        cell.rateView.addSubview(view)
        view.centerInSuperview()
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vcDetailes = storyboard?.instantiateViewController(withIdentifier: "showDatielsVC") as? showDatielsVC
        vcDetailes?.id = id_places[indexPath.row].id
        self.navigationController?.pushViewController(vcDetailes!, animated: true)
    }

}

extension allPlacessVC : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        let width = (screenWidth-30)/2
        return CGSize(width: width, height: 300)
    }
}
extension allPlacessVC : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
}


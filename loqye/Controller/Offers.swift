//
//  Offers.swift
//  loqye
//
//  Created by youssef on 12/23/18.
//  Copyright © 2018 youssef. All rights reserved.
//

import UIKit
import Cosmos
import TinyConstraints

class Offers: UIViewController {
    var AllPlaces = [OffersData]()
    var id = 0
    var name = ""
    fileprivate func cosmonView (retaing : Double ) -> CosmosView {
        var cosmosView : CosmosView{
            let view = CosmosView()
            
            view.settings.fillMode = .half
            view.text = "التقيم:"
            view.settings.textFont = UIFont(name: "Avenir", size: 15)!
            view.settings.textColor = .black
            view.settings.textMargin = 0
            view.settings.updateOnTouch = false
            view.rating = retaing
            view.settings.textMargin = 5
            return view
        }
       return cosmosView
    }
    
    
    @IBOutlet weak var collectionViewPlaces: UICollectionView!
    
    var spanner : UIActivityIndicatorView?
    var screnSize = UIScreen.main.bounds
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionViewPlaces.dataSource = self
        collectionViewPlaces.delegate = self
        addspanner()
        loadData()
       title = "العروض"
    
    }
    func loadData()  {
        API.show_offer { (sucsse:Bool, DataOffers:[OffersData]?) in
            if sucsse{
                
                guard let data = DataOffers else{
                    return
                }
                self.AllPlaces = data
                print(data)
                self.collectionViewPlaces.reloadData()
                self.removerspanner()
                
                
            }else{
                
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

extension Offers: UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(AllPlaces.count)
        return AllPlaces.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "placescell", for: indexPath) as! offerCell
        
       
        
        cell.lblPrice.text = "\(self.AllPlaces[indexPath.row].price)"
        cell.lblPriceAfterPr.text = "\(self.AllPlaces[indexPath.row].price_after_discount)"
        print(self.AllPlaces[indexPath.row].price_after_discount)
        cell.place_Title.text = self.AllPlaces[indexPath.row].title
        cell.Place_image.image = self.AllPlaces[indexPath.row].image
        cell.lblprcenage.text = self.AllPlaces[indexPath.row].precentage
       let view = cosmonView(retaing: Double(AllPlaces[indexPath.row].rating))
        cell.rateView.addSubview(view)
        view.rightToSuperview()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.id = AllPlaces[indexPath.row].id
        self.name = AllPlaces[indexPath.row].title
        print("id is \(id)")
        performSegue(withIdentifier: "fromOfferShowDatails", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! showDatielsVC
        vc.titlename = self.name
        vc.id = self.id
    }
}

extension Offers : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        let width = (screenWidth-30)/2
        return CGSize(width: width, height: 300)
    }
}

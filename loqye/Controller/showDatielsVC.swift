//
//  showDatielsVC.swift
//  loqye
//
//  Created by youssef on 1/15/19.
//  Copyright © 2019 youssef. All rights reserved.
//

import UIKit
import Kingfisher
import Firebase
class showDatielsVC: UIViewController {

    var ifIsEmptyText = "لا يوجد بيانات لعرضها"
    @IBOutlet weak var placeRule: UITextView!
    var id : Int = 0
    var spanner : UIActivityIndicatorView?
    var screnSize = UIScreen.main.bounds
    var imagesliderURL = [String]()
    var imagessliders = [UIImage]()
    var allDataPlaceDe : placeDetails?
    var currentPage = 0
    @IBOutlet weak var pagecontrollerImage: UIPageControl!
   
    
    @IBOutlet weak var imagecollectionView: UICollectionView!
    @IBOutlet weak var imageHell: UIImageView!
    
    @IBOutlet weak var pricelbl: UILabel!
    
    @IBOutlet weak var arealbl: UILabel!
    
    
    @IBOutlet weak var avaliblelbl: UILabel!
    
    @IBOutlet weak var distanceFromHere: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var staflbl: UILabel!
    
    @IBOutlet weak var scrollViewPlaceDatails: UIScrollView!
    @IBOutlet weak var numberOfRoom: UILabel!
    
    @IBOutlet weak var numberOfChairlbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagecollectionView.dataSource = self
        imagecollectionView.delegate = self
        placeRule.delegate = self
        placeRule.isScrollEnabled = false
        addspanner()
    
        self.navigationController!.navigationBar.topItem!.title = "رجوع"
        
        handelAllData(id: id)
    
    }
    
  
    func handelAllData(id : Int) {
        print(id)
        if id > 0 {
            API.get_Place_by_id(places_id: id) { (succes:Bool, Alldata:placeDetails?) in
                if succes{
                    guard let dataPlace = Alldata else{
                        return
                    }
                    self.allDataPlaceDe = dataPlace
                    
                    if dataPlace.area == ""{
                        self.arealbl.text = self.ifIsEmptyText
                    }else{
                         self.arealbl.text = dataPlace.area
                    }
                    if dataPlace.address == "" {
                        self.location.text = self.ifIsEmptyText
                    }else{
                        self.location.text = dataPlace.address
                    }
                    if dataPlace.availiable == "" {
                        self.avaliblelbl.text = self.ifIsEmptyText
                    }else{
                        self.avaliblelbl.text = dataPlace.availiable
                    }
                    if dataPlace.workers == "" {
                        self.staflbl.text = self.ifIsEmptyText
                    }else{
                        self.staflbl.text = dataPlace.workers
                    }
                    self.imageHell.image = dataPlace.image
                    if dataPlace.chairs == ""{
                        self.numberOfChairlbl.text = self.ifIsEmptyText
                    }else{
                        self.numberOfChairlbl.text = dataPlace.chairs
                    }
                    if dataPlace.rooms == ""{
                        self.numberOfRoom.text = self.ifIsEmptyText
                    }else{
                        self.numberOfRoom.text = dataPlace.rooms
                    }
                    self.imagesliderURL = dataPlace.images
                    DispatchQueue.main.async(execute: {
                      
                        self.imagecollectionView.reloadData()
                    })
                    
                    self.pricelbl.text = "\(dataPlace.price)"
                    self.distanceFromHere.text = self.ifIsEmptyText
                    self.pagecontrollerImage.numberOfPages = dataPlace.images.count
                    self.placeRule.text = dataPlace.details
                    self.scrollViewPlaceDatails.isHidden = false
                    self.removerspanner()
                    
                }
                else{
                    let alert = UIAlertController(title: "خطا", message: "هناك مشكله في اتصال الانترنت", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: { (UIAlertAction) in
                        self.dismiss(animated: true, completion: nil)
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }else{
            print("id = 0")
        }
    }
    
    @IBAction func reserveBtn(_ sender: Any) {
        
        Auth.auth().addStateDidChangeListener({ (auth, users) in
            if users != nil{
                self.performSegue(withIdentifier: "reserve", sender: nil)
                print(users?.uid)
            }
            else{
                self.performSegue(withIdentifier: "createEmailToReservation", sender: nil)
            }
        })
            
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? reservePlace {
            vc.id = self.id
            vc.allDataPlace = self.allDataPlaceDe
            
        }else{
            print("logOut")
        }
        
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

}
extension showDatielsVC: UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if imagesliderURL.count > 0{
            return imagesliderURL.count
        }else{
            return 4
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sliderCell", for: indexPath) as! sliderCell
        let imaged = UIImage(named: "imd")
        if imagessliders.count > 0{
            for url in self.imagesliderURL {
                let URL_image = URL(string: url)
                cell.sliderimage.kf.setImage(with: URL_image, placeholder: imaged, options: [.transition(ImageTransition.flipFromLeft(0.5))], progressBlock: nil) { (image, error, cache, url) in
                    self.imagessliders.append(image!)
                }
                
            }
        
        }else {
            cell.image = UIImage(named: "imd")
        }
        
        return cell
        
    }
}

extension showDatielsVC : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: ((collectionView.frame.width)-30/4), height: collectionView.frame.height)
    }
    
    
}

extension showDatielsVC : UICollectionViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        currentPage = Int(scrollView.contentOffset.x / self.imagecollectionView.frame.width)
        pagecontrollerImage.currentPage = currentPage
    }
}

extension showDatielsVC : UITextViewDelegate{
    
}

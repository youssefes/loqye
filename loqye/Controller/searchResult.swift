//
//  searchResult.swift
//  loqye
//
//  Created by youssef on 12/27/18.
//  Copyright © 2018 youssef. All rights reserved.
//

import UIKit
import Cosmos
import TinyConstraints

class searchResult: UIViewController {
    var id = 0
    lazy var cosmosView : CosmosView = {
        var view = CosmosView()
        return view
    }()

    var text = ""
    var spanner : UIActivityIndicatorView?
    @IBOutlet weak var lbl_no_result: UILabel!
    var screnSize = UIScreen.main.bounds
    @IBOutlet weak var collectionsearch: UICollectionView!
    var data = [dataByName]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionsearch.dataSource = self
        collectionsearch.delegate = self
        HandelData()
    }
    
    @IBAction func btnBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func HandelData(){
        addspanner()
        API.search_By_place(name: self.text) { (success:Bool, data:[dataByName]?) in
            if success{
                guard  let datase = data else{
                    return
                }
                self.data = datase
                self.removerspanner()
                self.collectionsearch.reloadData()
                
            }else{
                self.lbl_no_result.isHidden = false
                self.lbl_no_result.text = "حدث مشكلة ما تاكد من وجود الانترنت"
                self.collectionsearch.isHidden = true
                self.removerspanner()
            }
            if self.data.count == 0{
                self.lbl_no_result.isHidden = false
                self.collectionsearch.isHidden = true
                self.removerspanner()
            }
            
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

extension searchResult : UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cells", for: indexPath) as? ResultCellSearch{
            cell.imageViewse.image = data[indexPath.row].image
            cell.titleSe.text = data[indexPath.row].title
            print(data[indexPath.row].title)
            return cell
        }else{
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.id = data[indexPath.row].id
        performSegue(withIdentifier: "pla", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! showDatielsVC
        vc.id = self.id
    }
}

extension searchResult : UICollectionViewDelegate{
    
}

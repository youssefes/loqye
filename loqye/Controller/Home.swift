//
//  Home.swift
//  loqye
//
//  Created by youssef on 12/18/18.
//  Copyright © 2018 youssef. All rights reserved.
//

import UIKit

class Home: UIViewController {

    @IBOutlet weak var tableViewDepart: UITableView!
    var spanner : UIActivityIndicatorView?
     var screnSize = UIScreen.main.bounds
    var allPlaces = [Departs]()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewDepart.dataSource = self
        tableViewDepart.delegate = self
        tableViewDepart.tableFooterView = UIView()
        tableViewDepart.separatorInset = .zero
        tableViewDepart.contentInset = .zero
        
        addspanner()
        DispatchQueue.global(qos : .userInitiated).async {
            self.handeledData()
        }
    }
    
    func handeledData(){
        
        API.department { (error:Error?, departments:[Departs]?) in
            if error != nil{
                let alert = UIAlertController(title: "خطا", message: "هناك مشكله في اتصال الانترنت", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }else{
                guard let departs = departments else {
                    return
                }
                
                for department in departs{
                    self.allPlaces.append(department)
                    print(self.allPlaces)
                    DispatchQueue.main.async {
                         self.tableViewDepart.reloadData()
                    }
                   
                }
                self.removerspanner()
            }
            self.tableViewDepart.isHidden = false
            
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

extension Home : UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allPlaces.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "HomeCell")
        
        cell.textLabel?.text = allPlaces[indexPath.row].name
        cell.layer.masksToBounds = true
        cell.layer.borderWidth = 2
        cell.layer.borderColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        cell.textLabel?.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        cell.textLabel?.font = UIFont(name: "HelveticaNeue-UltraLight", size: 35.0)
        cell.textLabel?.textAlignment = .center
        cell.backgroundColor = UIColor.clear
        cell.selectionStyle = .none
        return cell
        }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        let cell = tableView.cellForRow(at: indexPath)
//        cell?.contentView.backgroundColor = UIColor.clear
        if let vc = storyboard?.instantiateViewController(withIdentifier: "allPlaceesVC") as? allPlacessVC{
            vc.id_Place = allPlaces[indexPath.row].id
            vc.name = allPlaces[indexPath.row].name
            self.navigationController?.pushViewController(vc, animated: true)
        }
       
        
        
    }
}
extension Home : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
   
}

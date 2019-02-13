//
//  faqVC.swift
//  loqye
//
//  Created by youssef on 2/9/19.
//  Copyright © 2019 youssef. All rights reserved.
//

import UIKit

class faqVC: UIViewController {

    var allArrayData = [Datafaq]()
    @IBOutlet weak var tableViewFaq: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableViewFaq.delegate = self
        tableViewFaq.dataSource = self
       handelData()
    }
    
    func handelData() {
        API.getFaq { (succes:Bool, data:[Datafaq]?) in
            
            if succes {
                guard let allData = data else {
                    return
                }
                self.allArrayData = allData
                self.tableViewFaq.reloadData()
                
            }
        }
    }
    
    @IBAction func BackBTN(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}

extension faqVC : UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allArrayData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "faqCell", for: indexPath) as? faqCell {
            print(allArrayData[indexPath.row].title)
            cell.titleLbl.text = allArrayData[indexPath.row].title
            cell.detailsLbl.text = allArrayData[indexPath.row].details
            return cell
        }else{
            return UITableViewCell()
        }
       
    }
}
extension faqVC : UITableViewDelegate{
    
}

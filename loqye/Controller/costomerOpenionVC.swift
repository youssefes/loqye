//
//  costomerOpenionVC.swift
//  loqye
//
//  Created by youssef on 1/26/19.
//  Copyright © 2019 youssef. All rights reserved.
//

import UIKit

class costomerOpenionVC: UIViewController {
    
    var openiens = [openine]()

    @IBOutlet weak var tableCustomer: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableCustomer.delegate = self
        tableCustomer.dataSource = self
        handelAllOpenin()
    }
    
    func handelAllOpenin()  {
        API.customerOpenin { (succes:Bool, data:[openine]?) in
            if succes{
                guard let alldata =  data else{
                    return
                }
                self.openiens = alldata
              
                self.tableCustomer.reloadData()
                self.tableCustomer.isHidden = false
                
            }
        }
    }
    
    @IBAction func backbtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension costomerOpenionVC : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return openiens.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customer", for: indexPath) as! customerOpenion
        cell.nameLbl.text = openiens[indexPath.row].name
        cell.openionlbl.text = openiens[indexPath.row].openines
        return cell
    }
    
   
}
extension costomerOpenionVC : UITableViewDelegate{
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}

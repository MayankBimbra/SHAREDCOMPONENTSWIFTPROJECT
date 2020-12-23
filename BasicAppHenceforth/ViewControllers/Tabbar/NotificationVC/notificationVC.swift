//
//  notificationVC.swift
//  BasicAppHenceforth
//
//  Created by NegiMac on 22/12/20.
//

import UIKit

class notificationVC: headerVC {


    // MARK: - UI COMPONENTS
    @IBOutlet weak var tblView: UITableView!
    
    
    // MARK: - VARIABLES
    
    
    // MARK: - OVERRIDE FUNCTIONS
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
}


// MARK: - SET UP UI
extension notificationVC{
    func setUpUI(){
        lblHeader.text = L10n.NotificationHeader.description
    }
}



// MARK: - UITABLE VIEW FUNCTIONS
extension notificationVC: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.notificationTVC.getValues(), for: indexPath) as! notificationTVC
        if indexPath.row == 0{
            cell.cellUnread()
        }else{
            cell.cellRead()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}

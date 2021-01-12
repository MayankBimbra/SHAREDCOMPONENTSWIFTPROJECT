//
//  notificationVC.swift
//  BasicAppHenceforth
//
//  Created by NegiMac on 22/12/20.
//

import UIKit
import ESPullToRefresh

class notificationVC: headerVC {


    // MARK: - UI COMPONENTS
    @IBOutlet weak var tblView: UITableView!
    
    
    // MARK: - VARIABLES
    var notificationVM : NotificationVM = NotificationVM.shared
    var notificationData : [NotificationC] = []
    
    
    // MARK: - OVERRIDE FUNCTIONS
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
}


// MARK: - SET UP UI
extension notificationVC{
    func setUpUI(){
        notificationVM.controller = self
        lblHeader.text = L10n.NotificationHeader.description
        
        notificationVM.fetchNotificationAPI()
        
        tblView.es.addPullToRefresh {
            self.notificationVM.pageNumber = 1
            self.notificationVM.canPaginate = true
            self.notificationVM.fetchNotificationAPI()
        }
    }
}



// MARK: - UITABLE VIEW FUNCTIONS
extension notificationVC: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notificationData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.notificationTVC.getValues(), for: indexPath) as! notificationTVC
        cell.setData(notificationData[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if self.notificationVM.apiHitOnce{
            if !self.notificationVM.apiHitting && self.notificationVM.canPaginate && indexPath.row == notificationData.count - 3{
                self.notificationVM.pageNumber += 1
                self.notificationVM.fetchNotificationAPI()
            }
        }
    }
}

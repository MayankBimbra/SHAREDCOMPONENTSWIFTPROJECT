//
//  chatVC.swift
//  BasicAppHenceforth
//
//  Created by NegiMac on 22/12/20.
//

import UIKit
import ESPullToRefresh

class chatVC: headerVC {

    // MARK: - UI COMPONENTS
    @IBOutlet weak var tblView: UITableView!
    
    
    // MARK: - VARIABLES
    var chatVM : ChatVM = ChatVM.shared
    var chatData : [ChatAPIElement] = []

    
    // MARK: - OVERRIDE FUNCTIONS
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
}


// MARK: - SET UP UI
extension chatVC{
    func setUpUI(){
        chatVM.controller = self
        lblHeader.text = L10n.ChatHeader.description

        chatVM.fetchChatAPI()
        
        tblView.es.addPullToRefresh {
            self.chatVM.pageNumber = 1
            self.chatVM.canPaginate = true
            self.chatVM.fetchChatAPI()
        }
    }
}


// MARK: - UITABLE VIEW FUNCTIONS
extension chatVC: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.chatTVC.getValues(), for: indexPath) as! chatTVC
        cell.setData(chatData[indexPath.row])
//        if indexPath.row == 0{
//            cell.cellUnread()
//        }else{
//            cell.cellRead()
//        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = chatInnerVC.instantiateFromAppStoryboard(appStoryboard: .Tabbar)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if self.chatVM.apiHitOnce{
            if !self.chatVM.apiHitting && self.chatVM.canPaginate && indexPath.row == chatData.count - 3{
                self.chatVM.pageNumber += 1
                self.chatVM.fetchChatAPI()
            }
        }
    }
}

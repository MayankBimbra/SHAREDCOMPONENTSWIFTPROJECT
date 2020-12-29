//
//  chatInnerVC.swift
//  BasicAppHenceforth
//
//  Created by NegiMac on 28/12/20.
//

import UIKit
import GrowingTextView
import IQKeyboardManagerSwift

class chatInnerVC: UIViewController {

    // MARK: - UI COMPONENTS
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var imgViewDP: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var tvChat: GrowingTextView!
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var btmConstValue: NSLayoutConstraint!
    @IBOutlet weak var tblView: UITableView!
    
    
    
    // MARK: - VARIABLES
    let sendImage = Asset.ic_send.image().withRenderingMode(.alwaysTemplate)
    
    
    // MARK: - OVERRIDE FUNCTIONS
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        IQKeyboardManager.shared.enable = false
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        IQKeyboardManager.shared.enable = true
        
//        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: self)
//        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: self)
    }
}


// MARK: - SET UP UI
extension chatInnerVC{
    func setUpUI(){
        
        imgViewDP.layer.cornerRadius = imgViewDP.frame.height/2

        lblName.textColor = UIColor.appWhiteColor
        lblName.font = UIFont.MontserratSemiBold(Size.XLarge.sizeValue())
        
        tvChat.textColor = UIColor.textColorTwo
        tvChat.backgroundColor = UIColor.unreadColor
        tvChat.layer.borderColor = UIColor.bGColor.cgColor
        tvChat.layer.borderWidth = 1
        tvChat.font = UIFont.MontserratMedium(Size.Medium.sizeValue())
        tvChat.placeholder = L10n.TypeMessage.description
        tvChat.placeholderColor = UIColor.textColorPlaceholder
        tvChat.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        tvChat.layer.cornerRadius = tvChat.frame.height/2

        btnSend.layer.cornerRadius = btnSend.frame.height/2
        btnSend.setImage(sendImage, for: .normal)
        btnSend.tintColor = UIColor.bGColor
        
        btnSend.addTarget(self, action: #selector(btnActSend(_:)),
                          for: .touchUpInside)
        btnBack.addTarget(self, action: #selector(btnActBack(_:)),
                          for: .touchUpInside)
        
        tblView.rowHeight = UITableView.automaticDimension
        tblView.estimatedRowHeight = 120
        tblView.reloadData()
    }
    
    func scrollToAbove(_ height: CGFloat){
        if tblView.contentSize.height - tblView.contentOffset.y > tblView.frame.height - height{
            tblView.setContentOffset(CGPoint(x: 0, y: tblView.contentOffset.y + height), animated: true)
        }
    }
}


// MARK: - TABLE VIEW FUNCTIONS
extension chatInnerVC: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row % 2 == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.chatInnerLeftTVC.getValues(), for: indexPath) as! chatInnerLeftTVC
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.chatInnerRightTVC.getValues(), for: indexPath) as! chatInnerRightTVC
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let hView = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 40))
        let mView = shadowView(frame: CGRect(x: screenWidth/2 - 40, y: 8, width: 80, height: 32))
        mView.cornarRadius = 16
        mView.backgroundColor = UIColor.appWhiteColor
        let lblDate = UILabel(frame: CGRect(x: 0, y: 0, width: 80, height: 32))
        lblDate.text = "TODAY"
        lblDate.font = UIFont.MontserratSemiBold(Size.Small.sizeValue())
        lblDate.textColor = UIColor.textColorOne
        lblDate.textAlignment = .center
        mView.addSubview(lblDate)
        hView.addSubview(mView)
        return hView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}


// MARK: - DELEGATE FUNCTIONS
extension chatInnerVC: UITextViewDelegate{
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentString: NSString = textView.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: text) as NSString
        if newString.length == 0{
            btnSend.tintColor = UIColor.bGColor
        }else{
            btnSend.tintColor = UIColor.white
        }
        return newString.length <= 520
    }
}


// MARK: - EXTERNAL FUNCTIONS
extension chatInnerVC{
    @objc func keyboardWillShow(_ notification: NSNotification){
        if let userInfo = notification.userInfo{
            let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue)
            let rect = keyboardFrame.cgRectValue
            btmConstValue.constant = CGFloat(rect.height) - self.view.safeAreaInsets.bottom + 12
            scrollToAbove(rect.height)
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }

    @objc func keyboardWillHide(_ notification: NSNotification){
        btmConstValue.constant = 16
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }

    @objc func btnActBack(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func btnActSend(_ sender: UIButton){
        tvChat.text = ""
    }
}

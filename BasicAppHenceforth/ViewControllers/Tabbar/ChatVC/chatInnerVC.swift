//
//  chatInnerVC.swift
//  BasicAppHenceforth
//
//  Created by NegiMac on 28/12/20.
//

import UIKit
import AVKit
import AVFoundation
import GrowingTextView
import MobileCoreServices
import IQKeyboardManagerSwift

class chatInnerVC: UIViewController {

    // MARK: - UI COMPONENTS
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var imgViewDP: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var tvChat: GrowingTextView!
    @IBOutlet weak var imgViewSend: UIImageView!
    @IBOutlet weak var btmConstValue: NSLayoutConstraint!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var btnAttach: UIButton!
    @IBOutlet weak var viewVideo: UIView!
    @IBOutlet weak var imgViewMicInner: UIImageView!
    @IBOutlet weak var lblTimer: UILabel!
    @IBOutlet weak var constAudioAnim: NSLayoutConstraint!
    @IBOutlet weak var stackTopView: UIStackView!
    @IBOutlet weak var btnCopy: UIButton!
    @IBOutlet weak var btnReply: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var btnShare: UIButton!
    @IBOutlet weak var btnFoward: UIButton!
    
    
    // MARK: - VARIABLES
    let sendImage = Asset.ic_send.image().withRenderingMode(.alwaysTemplate)
    let audioImage = Asset.ic_mic_white.image().withRenderingMode(.alwaysTemplate)
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    var audioPlayer: AVAudioPlayer!
    var timer : Timer!
    var voiceTimerCounter = 0
    var voiceTimer:Timer!
    var selectedCells : [IndexPath] = []
    
    
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

        imgViewSend.layer.cornerRadius = imgViewSend.frame.height/2
        imgViewSend.image = audioImage
        imgViewSend.tintColor = UIColor.appWhiteColor
        viewVideo.layer.cornerRadius = viewVideo.frame.height/2
        viewVideo.backgroundColor = UIColor.unreadColor
        viewVideo.layer.borderColor = UIColor.bGColor.cgColor
        viewVideo.layer.borderWidth = 1

        btnBack.addTarget(self, action: #selector(btnActBack(_:)),
                          for: .touchUpInside)
        btnAttach.addTarget(self, action: #selector(btnActAttach(_:)),
                            for: .touchUpInside)
        
        let tapAct = UITapGestureRecognizer(target: self,
                                            action: #selector(tapActSend(_:)))
        let longPressAct = UILongPressGestureRecognizer(target: self,
                                                        action: #selector(longPressActSend(_:)))
        imgViewSend.addGestureRecognizer(tapAct)
        imgViewSend.addGestureRecognizer(longPressAct)
        
        imgViewMicInner.image = audioImage
        imgViewMicInner.tintColor = UIColor.themeColor
        
        tblView.rowHeight = UITableView.automaticDimension
        tblView.estimatedRowHeight = 120
        tblView.reloadData()
        
        lblTimer.font = UIFont.MontserratMedium(Size.Medium.sizeValue())
        lblTimer.textColor = UIColor.textColorMain
        btnBack.tintColor = UIColor.appWhiteColor
        
        do{
            try AVAudioSession.sharedInstance().overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
        }catch(let error){
            print(error)
        }
        
        btnCopy.addTarget(self, action: #selector(btnActCopy(_:)), for: .touchUpInside)
        btnReply.addTarget(self, action: #selector(btnActReply(_:)), for: .touchUpInside)
        btnDelete.addTarget(self, action: #selector(btnActDelete(_:)), for: .touchUpInside)
        btnShare.addTarget(self, action: #selector(btnActShare(_:)), for: .touchUpInside)
        btnFoward.addTarget(self, action: #selector(btnActForward(_:)), for: .touchUpInside)
    }
    
    func scrollToAbove(_ height: CGFloat){
        if tblView.contentSize.height - tblView.contentOffset.y > tblView.frame.height - height{
            tblView.setContentOffset(CGPoint(x: 0, y: tblView.contentOffset.y + height), animated: true)
        }
    }
    
    func gestSelection(){
        if selectedCells.count == 0{
            imgViewDP.isHidden = false
            lblName.isHidden = false
            stackTopView.isHidden = true
            btnBack.setImage(Asset.ic_back_white.image().withRenderingMode(.alwaysTemplate), for: .normal)
        }else{
            imgViewDP.isHidden = true
            lblName.isHidden = true
            stackTopView.isHidden = false
            btnBack.setImage(Asset.ic_cancel_unselected.image().withRenderingMode(.alwaysTemplate), for: .normal)
        }
    }

    func prodTimeString(time: TimeInterval) -> String {
        let prodMinutes = Int(time) / 60 % 60
        let prodSeconds = Int(time) % 60
        return String(format: "%02d:%02d", prodMinutes, prodSeconds)
    }
    
    func tagCreator(_ index: IndexPath) -> Int{
        let sec = index.section
        let row = index.row
        
        if row < 10{
            return Int("\(sec)000\(row)") ?? 0
        } else if row < 100{
            return Int("\(sec)00\(row)") ?? 0
        } else if row < 1000{
            return Int("\(sec)0\(row)") ?? 0
        } else {
            return Int("\(sec)\(row)") ?? 0
        }
    }
}


// MARK: - TABLE VIEW FUNCTIONS
extension chatInnerVC: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 16
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let kTag = tagCreator(indexPath)
        if indexPath.row % 8 == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.chatInnerLeftTVC.getValues(), for: indexPath) as! chatInnerLeftTVC
            cell.contentView.tag = kTag
            cell.lngPressGest.addTarget(self, action: #selector(longPressActMsgs(_:)))
            cell.tapPressGest.addTarget(self, action: #selector(tapPressActMsgs(_:)))
            cell.onSelected(selectedCells.contains(indexPath))
            return cell
        }else if indexPath.row % 8 == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.chatInnerRightTVC.getValues(), for: indexPath) as! chatInnerRightTVC
            cell.contentView.tag = kTag
            cell.lngPressGest.addTarget(self, action: #selector(longPressActMsgs(_:)))
            cell.tapPressGest.addTarget(self, action: #selector(tapPressActMsgs(_:)))
            cell.onSelected(selectedCells.contains(indexPath))
            return cell
        }else if indexPath.row % 8 == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.chatInnerVideoLeftTVC.getValues(), for: indexPath) as! chatInnerVideoLeftTVC
            cell.contentView.tag = kTag
            cell.lngPressGest.addTarget(self, action: #selector(longPressActMsgs(_:)))
            cell.tapPressGest.addTarget(self, action: #selector(tapPressActMsgs(_:)))
            cell.forPicture()
            cell.onSelected(selectedCells.contains(indexPath))
            return cell
        }else if indexPath.row % 8 == 3{
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.chatInnerVideoRightTVC.getValues(), for: indexPath) as! chatInnerVideoRightTVC
            cell.contentView.tag = kTag
            cell.lngPressGest.addTarget(self, action: #selector(longPressActMsgs(_:)))
            cell.tapPressGest.addTarget(self, action: #selector(tapPressActMsgs(_:)))
            cell.forPicture()
            cell.onSelected(selectedCells.contains(indexPath))
            return cell
        }else if indexPath.row % 8 == 4{
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.chatInnerVideoLeftTVC.getValues(), for: indexPath) as! chatInnerVideoLeftTVC
            cell.contentView.tag = kTag
            cell.lngPressGest.addTarget(self, action: #selector(longPressActMsgs(_:)))
            cell.tapPressGest.addTarget(self, action: #selector(tapPressActMsgs(_:)))
            cell.forVideo()
            cell.onSelected(selectedCells.contains(indexPath))
            return cell
        }else if indexPath.row % 8 == 5{
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.chatInnerVideoRightTVC.getValues(), for: indexPath) as! chatInnerVideoRightTVC
            cell.contentView.tag = kTag
            cell.lngPressGest.addTarget(self, action: #selector(longPressActMsgs(_:)))
            cell.tapPressGest.addTarget(self, action: #selector(tapPressActMsgs(_:)))
            cell.forVideo()
            cell.onSelected(selectedCells.contains(indexPath))
            return cell
        }else if indexPath.row % 8 == 6{
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.chatInnerAudioLeftTVC.getValues(), for: indexPath) as! chatInnerAudioLeftTVC
            cell.contentView.tag = kTag
            cell.lngPressGest.addTarget(self, action: #selector(longPressActMsgs(_:)))
            cell.tapPressGest.addTarget(self, action: #selector(tapPressActMsgs(_:)))
            cell.onSelected(selectedCells.contains(indexPath))
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.chatInnerAudioRightTVC.getValues(), for: indexPath) as! chatInnerAudioRightTVC
            cell.contentView.tag = kTag
            cell.lngPressGest.addTarget(self, action: #selector(longPressActMsgs(_:)))
            cell.tapPressGest.addTarget(self, action: #selector(tapPressActMsgs(_:)))
            cell.onSelected(selectedCells.contains(indexPath))
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
            imgViewSend.image = audioImage
            btnAttach.isHidden = false
        }else{
            imgViewSend.image = sendImage
            btnAttach.isHidden = true
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

    @objc func btnActAttach(_ sender: UIButton){
        self.view.endEditing(true)
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: L10n.Camera.description, style: .default, handler: { _ in
            print("Camera")
        }))
        alert.addAction(UIAlertAction(title: L10n.Gallery.description, style: .default, handler: { _ in
            print("Gallery")
        }))
        alert.addAction(UIAlertAction(title: L10n.Location.description, style: .default, handler: { _ in
            print("Location")
        }))
        alert.addAction(UIAlertAction(title: L10n.Cancel.description, style: .cancel, handler: { _ in
            print("Cancel")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func btnActBack(_ sender: UIButton){
        if selectedCells.count > 0{
            selectedCells = []
            tblView.reloadData()
            gestSelection()
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
        
    @objc func tapActSend(_ sender: UITapGestureRecognizer){
        tvChat.text = ""
        imgViewSend.image = audioImage
        btnAttach.isHidden = false
    }
    
    @objc func longPressActSend(_ sender: UILongPressGestureRecognizer){
        if sender.state == UIGestureRecognizer.State.began {
            if tvChat.text == ""{
                if self.viewVideo.isHidden {
                    voiceTimerCounter = 0
                    self.voiceTimer =  Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
                    self.lblTimer.text = "00:00"
                    self.viewVideo.isHidden = false
                    self.constAudioAnim.constant = -(self.imgViewSend.frame.minX - 12)
                    UIView.animate(withDuration: 0.2, delay: 0.0, options: .transitionFlipFromLeft, animations: {
                        self.view.layoutIfNeeded()
                    }, completion: nil)
                }
//                self.startRecording()
            }
        } else if sender.state == UIGestureRecognizer.State.ended {
//            if audioRecorder == nil {
//            } else {
                self.voiceTimer.invalidate()
                self.constAudioAnim.constant = 0
                UIView.animate(withDuration: 0.5, delay: 0.5, options: .transitionFlipFromLeft, animations: {
                    self.view.layoutIfNeeded()
                    self.viewVideo.isHidden = true
                }, completion: nil)
//                self.finishRecording(success: true)
//            }
        }
    }
    
    @objc func updateCounter() {
        voiceTimerCounter += 1
        self.lblTimer.text = prodTimeString(time: TimeInterval(voiceTimerCounter))
        if voiceTimerCounter >= 120{
            self.voiceTimer.invalidate()
            self.constAudioAnim.constant = 0
            UIView.animate(withDuration: 0.5, delay: 0.5, options: .transitionFlipFromLeft, animations: {
                self.view.layoutIfNeeded()
                self.viewVideo.isHidden = true
            }, completion: nil)
//            self.finishRecording(success: true)

        }
    }
    
    @objc func longPressActMsgs(_ sender: UILongPressGestureRecognizer){
        if sender.state == UIGestureRecognizer.State.began {
            let kRow = (sender.view?.tag ?? 0)%10000
            let kSection = (sender.view?.tag ?? 0)/10000
            let kIndexPath = IndexPath(row: kRow, section: kSection)
            if selectedCells.contains(kIndexPath){
                let filterSel = selectedCells.filter { (index) -> Bool in
                    if index.row == kIndexPath.row && index.section == kIndexPath.section{
                        return false
                    }else{
                        return true
                    }
                }
                selectedCells = filterSel
            }else{
                selectedCells.append(kIndexPath)
            }
            tblView.reloadRows(at: [kIndexPath], with: .fade)
        }
        gestSelection()
    }
    
    @objc func tapPressActMsgs(_ sender: UITapGestureRecognizer){
        if selectedCells.count == 0{
            return
        }
        
        let kRow = (sender.view?.tag ?? 0)%10000
        let kSection = (sender.view?.tag ?? 0)/10000
        let kIndexPath = IndexPath(row: kRow, section: kSection)
        if selectedCells.contains(kIndexPath){
            let filterSel = selectedCells.filter { (index) -> Bool in
                if index.row == kIndexPath.row && index.section == kIndexPath.section{
                    return false
                }else{
                    return true
                }
            }
            selectedCells = filterSel
        }else{
            selectedCells.append(kIndexPath)
        }
        tblView.reloadRows(at: [kIndexPath], with: .fade)
        gestSelection()
    }
    
    @objc func btnActCopy(_ sender: UIButton){
        
    }

    @objc func btnActReply(_ sender: UIButton){
        
    }

    @objc func btnActDelete(_ sender: UIButton){
        
    }

    @objc func btnActShare(_ sender: UIButton){
        
    }

    @objc func btnActForward(_ sender: UIButton){
        
    }

}

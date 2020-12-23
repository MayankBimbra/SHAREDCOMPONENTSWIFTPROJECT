import Foundation
import SkyFloatingLabelTextField
import IQKeyboardManagerSwift
import Toaster
import PopupDialog
import SwiftEntryKit
import var CommonCrypto.CC_MD5_DIGEST_LENGTH
import func CommonCrypto.CC_MD5
import typealias CommonCrypto.CC_LONG

class EntryAttributeWrapper {
    var attributes: EKAttributes
    init(with attributes: EKAttributes) {
        self.attributes = attributes
    }
}

class CommonFunctions {
    var attributes = EKAttributes()
    let kView = UIView()
    let lblTitle = UILabel()
    let tf = UITextField()
    let btn = UIButton()

//    static func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat{
//        let label:UILabel = UILabel(frame: CGRectMake(0, 0, width, CGFloat.greatestFiniteMagnitude))
//        label.numberOfLines = 0
//        label.lineBreakMode = NSLineBreakMode.byWordWrapping
//        label.font = font
//        label.text = text
//
//        label.sizeToFit()
//        return label.frame.height
//    }
    
    // MARK: - UI SETTING
    static func setbuttonBoarder(_ radius : CGFloat, _ btns : [UIButton]){
        for btn in btns{
            btn.layer.cornerRadius = radius
        }
    }

    
    static func loginTextField(_ tfs: [UITextField]){
        for tf in tfs{
            tf.textColor = Colors.btnborderColorbnb.color()
            tf.layer.borderColor = Colors.btnBorderGrayBnb.color().cgColor
            tf.layer.borderWidth = 1.0
            tf.layer.cornerRadius = 2.0
            tf.rightViewMode = UITextField.ViewMode.always
            tf.leftViewMode = UITextField.ViewMode.always
        }
    }
    
    static func buttons(_ btns: [UIButton]){
        for btn in btns{
            btn.layer.cornerRadius = 2.0
            btn.layer.borderWidth = 1.0
            btn.layer.borderColor = Colors.btnBorderGrayBnb.color().cgColor
            btn.setTitleColor(.white, for: .normal)
            btn.setTitleColor(Colors.btnborderColorbnb.color(), for: .normal)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: CGFloat(16.0))
        }
    }
    
    static func buttonHide(_ btns : [UIButton]){
        for btn in btns{
            btn.isHidden = true
            btn.layer.cornerRadius = 2
        }
    }
    
    static func buttonBorder(_ button: [UIButton]){
        for bttn in button{
            bttn.layer.cornerRadius = 4.0
            bttn.layer.borderWidth = 0.6
            bttn.layer.borderColor = Colors.btnborderColorbnb.color().cgColor
//            bttn.backgroundColor = UIColor.white
            bttn.setTitleColor(Colors.btnborderColorbnb.color(), for: .normal)
            bttn.titleLabel?.font = UIFont.systemFont(ofSize: CGFloat(16.0))
        }
    }
    
    static func buttonUpcoming(_ btns: [UIButton]){
        for btn in btns{
            btn.layer.cornerRadius = 4.0
//            btn.backgroundColor = Colors.dotiSignUpOrColor.color()
            btn.setTitleColor(.white, for: .normal)
        }
    }
    
    static func buttonOngoing(_ btns: [UIButton]){
        for btn in btns{
            btn.layer.cornerRadius = 4.0
//            btn.backgroundColor = Colors.dotiButtonColor.color()
            btn.setTitleColor(.white, for: .normal)
        }
    }
    
    static func normalSkyTF(_ tf : SkyFloatingLabelTextField, img: UIImage?, placeHolder : String){
        tf.textColor = UIColor.textColorMain
        tf.lineColor = UIColor.textColorPlaceholder
        tf.tintColor = UIColor.textColorMain
        tf.titleColor = UIColor.textColorPlaceholder
        tf.titleErrorColor = UIColor.textColorPlaceholder
        tf.selectedTitleColor = UIColor.themeColor
        tf.selectedLineColor = UIColor.themeColor
        tf.lineErrorColor = UIColor.textColorPlaceholder
        tf.placeholderColor = UIColor.textColorPlaceholder
        
        tf.lineHeight = 1
        tf.selectedLineHeight = 1
        
        tf.placeholder = placeHolder
        
        tf.font = UIFont.MontserratMedium(Size.Medium.sizeValue())
        tf.titleFont = UIFont.MontserratMedium(Size.Small.sizeValue())
        tf.placeholderFont = UIFont.MontserratMedium(Size.Medium.sizeValue())
            
        if img != nil{
            let imgVw = UIImageView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
            imgVw.contentMode = .bottom
            imgVw.image = img?.imageWithInsets(insets: UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6))?.withRenderingMode(.alwaysTemplate)
            imgVw.tintColor = UIColor.themeColor
            tf.rightView = imgVw
            tf.rightViewMode = .always
        }
    }
    
    static func normalSkyTFBtn(_ tf : SkyFloatingLabelTextField, btn: UIButton, placeHolder : String){
        
        tf.disableAutoFill()
        
        let img1 = Asset.ic_eye_review.image().imageWithInsets(insets: UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6))?.withRenderingMode(.alwaysTemplate)
        let img2 = Asset.ic_hideeye_review.image().imageWithInsets(insets: UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6))?.withRenderingMode(.alwaysTemplate)

        tf.textColor = UIColor.textColorMain
        tf.lineColor = UIColor.textColorPlaceholder
        tf.tintColor = UIColor.textColorMain
        tf.titleColor = UIColor.textColorPlaceholder
        tf.titleErrorColor = UIColor.textColorPlaceholder
        tf.selectedTitleColor = UIColor.themeColor
        tf.selectedLineColor = UIColor.themeColor
        tf.lineErrorColor = UIColor.textColorPlaceholder
        tf.placeholderColor = UIColor.textColorPlaceholder
        
        tf.lineHeight = 1
        tf.selectedLineHeight = 1
        
        tf.placeholder = placeHolder
        
        tf.font = UIFont.MontserratMedium(Size.Medium.sizeValue())
        tf.titleFont = UIFont.MontserratMedium(Size.Small.sizeValue())
        tf.placeholderFont = UIFont.MontserratMedium(Size.Medium.sizeValue())
            
        if tf.isSecureTextEntry {
            btn.setImage(img2, for: .normal)
        }else{
            btn.setImage(img1, for: .normal)
        }
        btn.tintColor = UIColor.themeColor
        tf.rightView = btn
        tf.rightViewMode = .always
    }
    
    static func toster(_ txt : String){
        let attributesWrapper: EntryAttributeWrapper = {
            var attributes = EKAttributes()
            attributes.positionConstraints = .fullWidth
            attributes.hapticFeedbackType = .success
            attributes.positionConstraints.safeArea = .empty(fillSafeArea: true)
            attributes.entryBackground = .visualEffect(style: .dark)
            return EntryAttributeWrapper(with: attributes)
        }()
            let title = EKProperty.LabelContent(
                text: txt,
                style: EKProperty.LabelStyle(font: UIFont.boldSystemFont(ofSize: 16), color: EKColor.white, alignment: NSTextAlignment.center, displayMode: .light, numberOfLines: 0)
            )
            let description = EKProperty.LabelContent(
                text: "",
                style: EKProperty.LabelStyle(
                    font: UIFont.systemFont(ofSize: 1, weight: .light),
                    color: .black
                )
            )
            let simpleMessage = EKSimpleMessage(
                title: title,
                description: description
            )
            let notificationMessage = EKNotificationMessage(simpleMessage: simpleMessage)
            let contentView = EKNotificationMessageView(with: notificationMessage)
            SwiftEntryKit.display(entry: contentView, using: attributesWrapper.attributes)
    }
    
    static func buttonSocial(_ btnx: [UIButton]){
        for btnn in btnx{
//            setBGColor(btnn)
            btnn.backgroundColor = UIColor.white
            btnn.layer.borderWidth = 1.0
            btnn.layer.borderColor = Colors.btnborderColorbnb.color().cgColor
        }
    }
    
    static func setBorderAndColorView(_ view : [UIView]){
        for vw in view{
            vw.layer.cornerRadius = 6.0
            vw.layer.borderWidth = 1.0
            vw.layer.borderColor = Colors.btnBorderGrayBnb.color().cgColor
        }
    }
    
    static func buttonSetAddress(_ btnns : [UIButton]){
        for b in btnns{
            b.layer.cornerRadius = 14.0
        }
    }
    
    static func btnShadow(_ btns: [UIButton]){
        for btnSH in btns{
            btnSH.backgroundColor = UIColor.white
            btnSH.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.15).cgColor
            btnSH.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
            btnSH.layer.shadowOpacity = 0.6
            btnSH.layer.shadowRadius = 3.0
            btnSH.layer.cornerRadius = 18.5
        }
    }
    
    static func shadowView(_ img: [UIView]){
        for imgs in img{
            imgs.backgroundColor = UIColor.white
            imgs.clipsToBounds = true
            imgs.layer.masksToBounds = false
            imgs.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0).cgColor
            imgs.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
            imgs.layer.shadowOpacity = 0.2
            imgs.layer.shadowRadius = 5.0
            imgs.layer.cornerRadius = 8.0
        }
       }
    
    
    static func sendAttText( _ texts : [String], fonts: [UIFont], color: [UIColor], link: [URL?], alingment : NSTextAlignment) -> NSMutableAttributedString{
        
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = alingment
        
        let mutString : NSMutableAttributedString = NSMutableAttributedString(string: "")
        
        for (num, text) in texts.enumerated() {
            let att = [NSAttributedString.Key.foregroundColor: color[num], NSAttributedString.Key.font: fonts[num]] as [NSAttributedString.Key : Any]
            let attString = NSAttributedString(string: text, attributes: att)
            
            mutString.append(attString)
            
            if link[num] != nil{
                mutString.addAttributes([.link: link[num]!], range: NSRange(location: mutString.length - text.count, length: text.count))
            }
            
        }
        mutString.addAttributes([NSAttributedString.Key.paragraphStyle:paragraph], range: NSRange(location: 0, length: mutString.string.count))
        return mutString
    }
    
    static func sendAttText( _ texts : [String], fonts: [UIFont], color: [UIColor], alingment : NSTextAlignment, spacing : CGFloat = 4) -> NSMutableAttributedString{
        
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = alingment
        paragraph.lineSpacing = spacing

        let mutString : NSMutableAttributedString = NSMutableAttributedString(string: "")
        
        for (num, text) in texts.enumerated() {
            let att = [NSAttributedString.Key.foregroundColor: color[num], NSAttributedString.Key.font: fonts[num]] as [NSAttributedString.Key : Any]
            let attString = NSAttributedString(string: text, attributes: att)
            
            mutString.append(attString)
            
        }
        mutString.addAttributes([NSAttributedString.Key.paragraphStyle:paragraph], range: NSRange(location: 0, length: mutString.string.count))
        return mutString
    }
    
    static func getFont(fontName name : String, maximumFontValue size: CGFloat) -> UIFont{
        let font = UIFont(name: name, size: size)
        let fontMetrics = UIFontMetrics(forTextStyle: .body)
        return fontMetrics.scaledFont(for: font!)
    }
    
    // for getting navigation controller
    static func getNavigationController() -> UINavigationController{
        return UIApplication.shared.keyWindow?.rootViewController as! UINavigationController
    }
    
    // for getting top most view controller
    static func getTopMostViewController() -> UIViewController?{
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
            // topController should now be your topmost view controller
        }
        return nil
    }
    static func alertView(title:String,message:String,button:String, buttonResult: @escaping (String)->(),destructive:Bool,secondButton:String, secondButtonResult: @escaping (String)->())-> UIAlertController{
        
        // call AlertController define its buttons and its functions and show it
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: button, style: UIAlertAction.Style.default) { (result : UIAlertAction) -> Void in
            buttonResult("")
        }
        if(destructive){
            
            let DestructiveAction = UIAlertAction(title: secondButton, style: UIAlertAction.Style.destructive) { (result : UIAlertAction) -> Void in
                secondButtonResult("")
            }
            alertController.addAction(DestructiveAction)
            
        }
        
        alertController.addAction(okAction)
        //    self.presentViewController(alertController, animated: true, completion: nil)
        return alertController
    }
    
    static func isValidEmail(_ testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    static func invalidPassTyp(_ checkpass:String) -> Bool{
        let passwordCheck = "(?=.*[A-Z])(?=.*[d$@$!%*?&#.><,)/+*(])(?=.*[0-9])(?=.*[a-z]).{8,}"
        let password = NSPredicate(format:"SELF MATCHES %@", passwordCheck)
        return password.evaluate(with: checkpass)
    }
    
    static func validPhoneNumber(_ checkphone:String) -> Bool{
        let numberCheck = "^((\\+)|(00))[0-9]{6,14}$"
        let number = NSPredicate(format:"SELF MATCHES %@", numberCheck)
        return number.evaluate(with: checkphone)
    }
    
    // for showing error alert message
    static func showErrorAlert(message: String){
        showAlertWithTitle(title: "Error", message: message, firstBtn: "Close", firstButtonResult: { _ in }, firstBtnStyle: UIAlertAction.Style.cancel, secondBtn: nil, secondButtonResult: { _ in }, secondBtnStyle: UIAlertAction.Style.default)
    }
    
    // for showing any alert message
    static func showAlertWithTitle(title : String?,message : String?, firstBtn: String?, firstButtonResult: @escaping (String)->(), firstBtnStyle: UIAlertAction.Style = UIAlertAction.Style.default, secondBtn: String?, secondButtonResult: @escaping (String)->(), secondBtnStyle: UIAlertAction.Style = UIAlertAction.Style.default) {
        let alertVc = UIAlertController.init(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        if firstBtn != nil{
            alertVc.addAction(UIAlertAction.init(title: firstBtn!, style: firstBtnStyle, handler: { _ in
                firstButtonResult("")
            }))
        }
        if secondBtn != nil{
            alertVc.addAction(UIAlertAction.init(title: secondBtn!, style: secondBtnStyle, handler: { _ in
                secondButtonResult("")
            }))
        }
        let currentVc = getTopMostViewController()
        currentVc!.present(alertVc, animated: true, completion: nil)
    }
    
//    //MARK:-  function for get country from lat, long
//    static func getPlace(for location: CLLocation, completion: @escaping (CLPlacemark?) -> Void) {
//        let geocoder = CLGeocoder()
//        geocoder.reverseGeocodeLocation(location) { placemarks, error in
//            guard error == nil else {
//              print("*** Error in \(#function): \(error!.localizedDescription)")
//              completion(nil)
//              return
//            }
//            guard let placemark = placemarks?[0] else {
//              print("*** Error in \(#function): placemark is nil")
//              completion(nil)
//              return
//            }
//            completion(placemark)
//        }
//    }
    
    // for removing any alert message currently above screen
    static func removeAlert(){
        let currentVc = getTopMostViewController()
        if currentVc!.isKind(of: UIAlertController.self){
            currentVc?.dismiss(animated: true, completion: nil)
        }
        for subViews in (currentVc?.view.subviews)!{
            if subViews.isKind(of: UIAlertController.self){
                currentVc?.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    static func hideLoader(){
        let topView = getTopMostViewController()?.view
        if topView != nil{
            for (num,subView) in topView!.subviews.enumerated(){
                if subView.tag == 111{
                    topView!.subviews[num].removeFromSuperview()
                }
            }
        }
    }
    
    static func hideLoader(_ onView : UIView){
        let topView = onView
        for (num,subView) in topView.subviews.enumerated(){
            if subView.tag == 111{
                topView.subviews[num].removeFromSuperview()
            }
        }
    }
    
    static func getDate(_ date: String) -> String {
        if date == "" || date == "Day Month Year"{
           return ""
        }else{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            dateFormatter.timeZone = NSTimeZone(name: "GMT") as TimeZone?
            let date1 = dateFormatter.date(from: date)
            dateFormatter.dateFormat = "MMMM d, yyyy"
            dateFormatter.timeZone = NSTimeZone(name: "GMT") as TimeZone?
            return dateFormatter.string(from: date1 ?? Date())
        }
    }
    
    static func getOnlyYear(_ date: String) -> String {
        if date == "" || date == "Day Month Year"{
           return ""
        }else{
            let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            dateFormatter.timeZone = NSTimeZone(name: "GMT") as TimeZone?
            let date1 = dateFormatter.date(from: date)
            dateFormatter.dateFormat = "yyyy"
            dateFormatter.timeZone = NSTimeZone(name: "GMT") as TimeZone?
            return dateFormatter.string(from: date1 ?? Date())
        }
    }
    
    static func dateForStatus(_ date: String) -> String {
       if date == "" || date == "Day Month Year"{
           return ""
        }else{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            let date1 = dateFormatter.date(from: date)
            dateFormatter.dateFormat = "EEE, d MMM"
            dateFormatter.timeZone = NSTimeZone(name: "GMT") as TimeZone?
            return dateFormatter.string(from: date1 ?? Date())
        }
    }
    
    static func dateForMyReviews(_ date: String) -> String {
       if date == "" || date == "Day Month Year"{
           return ""
        }else{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            let date1 = dateFormatter.date(from: date)
            dateFormatter.dateFormat = "EEEE, d MMM."
            dateFormatter.timeZone = NSTimeZone(name: "GMT") as TimeZone?
            return dateFormatter.string(from: date1  ?? Date())
        }
    }
    
    static func dateForCollection(_ date: String) -> String {
       if date == "" || date == "Day Month Year"{
           return ""
        }else{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            let date1 = dateFormatter.date(from: date)
            dateFormatter.dateFormat = "h:mm a 'on' d'th' MMM. yyyy"
            dateFormatter.timeZone = NSTimeZone(name: "GMT") as TimeZone?
            return dateFormatter.string(from: date1 ?? Date())
        }
    }
    
    static func getDateForSearched(_ date: String) -> String {
       if date == "" || date == "Day Month Year"{
           return ""
        }else{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            let date1 = dateFormatter.date(from: date)
            dateFormatter.dateFormat = "dd MMM"
            dateFormatter.timeZone = NSTimeZone(name: "GMT") as TimeZone?
            return dateFormatter.string(from: date1 ?? Date())
        }
    }
    
    static func dateForBilling(_ date: String) -> String {
       if date == ""{
            return ""
       }else if date == "Not paid yet"{
            return "Not paid yet"
       }else{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            let date1 = dateFormatter.date(from: date)
            dateFormatter.dateFormat = "dd MMM. yyyy"
            dateFormatter.timeZone = NSTimeZone(name: "GMT") as TimeZone?
            return dateFormatter.string(from: date1 ?? Date())
        }
    }
    
    static func dateForNotofication(_ date: String) -> String {
       if date == "" || date == "Day Month Year" || date == "Not Seen Yet"{
           return ""
        }else{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            let date1 = dateFormatter.date(from: date)
            dateFormatter.dateFormat = "d MMM. 'at' h:mm a"
            dateFormatter.timeZone = NSTimeZone(name: "UTC+5:30") as TimeZone?
            return dateFormatter.string(from: date1 ?? Date())
        }
    }
    
    static func onlyMothFroPayment(_ date: String) -> String {
       if date == "" || date == "Day Month Year"{
           return ""
        }else{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            let date1 = dateFormatter.date(from: date)
            dateFormatter.dateFormat = "MMM."
            dateFormatter.timeZone = NSTimeZone(name: "GMT") as TimeZone?
            return dateFormatter.string(from: date1 ?? Date())
        }
    }
    
    static func dateForInvoice(_ date: String) -> String {
       if date == "" || date == "Day Month Year"{
           return ""
        }else{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            let date1 = dateFormatter.date(from: date)
            dateFormatter.dateFormat = "dd/MM/yyyy"
            dateFormatter.timeZone = NSTimeZone(name: "GMT") as TimeZone?
            return dateFormatter.string(from: date1 ?? Date())
        }
    }
    
    static func getDateOfBirth(_ date: String) -> String {
           if date == "N/A"{
              return "N/A"
           }else{
               let dateFormatter = DateFormatter()
                   dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
               dateFormatter.timeZone = NSTimeZone(name: "GMT") as TimeZone?
               let date1 = dateFormatter.date(from: date)
               dateFormatter.dateFormat = "d MMM yyyy"
               dateFormatter.timeZone = NSTimeZone(name: "GMT") as TimeZone?
               return dateFormatter.string(from: date1 ?? Date())
           }
       }
    
    static func getTime(_ date: String) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            dateFormatter.timeZone = NSTimeZone(name: "GMT") as TimeZone?
            let date1 = dateFormatter.date(from: date)
            dateFormatter.dateFormat = "h:mm a"
            return dateFormatter.string(from: date1 ?? Date())
    }
    
    static func getTimeIn24(_ date: String) -> String {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                dateFormatter.timeZone = NSTimeZone(name: "GMT") as TimeZone?
                let date1 = dateFormatter.date(from: date)
                dateFormatter.dateFormat = "HH:mm:ss"
                return dateFormatter.string(from: date1 ?? Date())
        }
    
    static func getTDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone(name: "GMT") as TimeZone?
        dateFormatter.dateFormat = "dd-MM-yyyy"
        dateFormatter.timeZone = NSTimeZone.local
        return dateFormatter.string(from: date)
    }
    
    static func getCDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        dateFormatter.dateFormat = "d MMM yyyy"
        dateFormatter.timeZone = NSTimeZone(name: "GMT") as TimeZone?
        return dateFormatter.string(from: date)
    }
    
    static func getChatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone(name: "GMT") as TimeZone?
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.timeZone = NSTimeZone(name: "GMT") as TimeZone?
        return dateFormatter.string(from: date) + ".000Z"
    }
    
    static func setDate(_ date: String) -> String {
        if date == "" || date == "Day Month Year"{
            return ""
        }else{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "d MMM yyyy"
            dateFormatter.timeZone = NSTimeZone(name: "GMT") as TimeZone?
            let date1 = dateFormatter.date(from: date)
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            dateFormatter.timeZone = NSTimeZone(name: "GMT") as TimeZone?
            return dateFormatter.string(from: date1 ?? Date())
        }
    }
    
    static func setDateSubs(_ date: String) -> String {
        if date == "" || date == "Day Month Year"{
            return ""
        }else{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            dateFormatter.timeZone = NSTimeZone(name: "GMT") as TimeZone?
            let date1 = dateFormatter.date(from: date)
            dateFormatter.dateFormat = "yyyy-MM-dd"
            dateFormatter.timeZone = NSTimeZone(name: "GMT") as TimeZone?
            return dateFormatter.string(from: date1 ?? Date()) + "T00:00:00.000Z"
        }
    }
    static func setDateSubsAddition(_ date: String) -> String {
        if date == "" || date == "Day Month Year"{
            return ""
        }else{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            dateFormatter.timeZone = NSTimeZone(name: "GMT") as TimeZone?
            let date1 = dateFormatter.date(from: date)
            dateFormatter.dateFormat = "yyyy-MM-dd"
            dateFormatter.timeZone = NSTimeZone(name: "GMT") as TimeZone?
            return dateFormatter.string(from: date1 ?? Date()) + "T01:00:00.000Z"
        }
    }
    
    static func setDateForSearch(_ date: String) -> String {
        if date == "" || date == "Day Month Year"{
            return ""
        }else{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            dateFormatter.timeZone = NSTimeZone(name: "GMT") as TimeZone?
            let date1 = dateFormatter.date(from: date)
            dateFormatter.dateFormat = "yyyy-MM-dd"
            dateFormatter.timeZone = NSTimeZone(name: "GMT") as TimeZone?
            return dateFormatter.string(from: date1 ?? Date()) + "T01:00:00.000Z"
        }
    }
    
    static func getDateMonth(_ date: String) -> String {
        if date == "" || date == "Day Month Year"{
           return ""
        }else{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            dateFormatter.timeZone = NSTimeZone(name: "GMT") as TimeZone?
            let date1 = dateFormatter.date(from: date)
            dateFormatter.dateFormat = "MMM yyyy"
            dateFormatter.timeZone = NSTimeZone(name: "GMT") as TimeZone?
            return dateFormatter.string(from: date1 ?? Date())
        }
    }
    
    
    static func getOnlyDate(_ date: String) -> Date? {
        if date == ""{
            return nil
        }else{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            dateFormatter.timeZone = NSTimeZone(name: "GMT") as TimeZone?
            return dateFormatter.date(from: date)
        }
    }
    
    static func getDateInDate(_ date: String) -> Date? {
        if date == ""{
            return nil
        }else{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            dateFormatter.timeZone = NSTimeZone(name: "GMT") as TimeZone?
            return dateFormatter.date(from: date)
        }
    }
    
    
    
    static func getImage(_ name : String, quality: Image_Quality) -> String{
        if name == ""{
            return ""
        }else{
            return "\(BASE_URL)image?filename=\(name)\(quality.rawValue)"
        }
    }
    
    static func getCurrentsDatesOnly(_ dates : [String]) -> [String]{
        var cDates : [String] = []
        for date in dates{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM yyyy"
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
            
            let dt = dateFormatter.date(from: date) ?? Date()
            
            if dt.compare(Date()) == .orderedDescending{
                cDates.append(date)
            }else{
                let dt = dateFormatter.string(from: Date())
                if dt == date{
                    cDates.append(date)
                }
            }
        }
        return cDates
    }
    
    static func getStartDateAndEndDate(_ prevDate : String) -> String{
        let dateFormatter = DateFormatter()
//        let date = Date()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "MMMM-yyyy"
        let date = dateFormatter1.date(from: prevDate) ?? Date()
        
        let comp: DateComponents = Calendar.current.dateComponents([.year, .month], from: date)
        let startOfMonth = Calendar.current.date(from: comp)!
        let startdate = dateFormatter.string(from: startOfMonth)
        print(dateFormatter.string(from: startOfMonth))
        
        var comps2 = DateComponents()
        comps2.month = 1
        comps2.day = -1
        let endOfMonth = Calendar.current.date(byAdding: comps2, to: startOfMonth)
        let endDate = dateFormatter.string(from: endOfMonth!)
        print(dateFormatter.string(from: endOfMonth!))
        return "\(startdate)T00:00:00.000Z" + " \(endDate)T01:00:00.000Z"
    }
    
    static func showLoader(){
        let topView = getTopMostViewController()?.view
        let loadingView = UIView(frame : CGRect(x: 0, y: 0, width: topView?.frame.width ?? 0, height: topView?.frame.height ?? 0))
        loadingView.backgroundColor = UIColor.black
        loadingView.alpha = 0.6
        let laodingFrame = SpinnerView(frame: CGRect(x: (topView?.frame.width ?? 0)/2 - 20, y: (topView?.frame.height ?? 0)/2 - 20, width: 40, height: 40))
        loadingView.addSubview(laodingFrame)
        loadingView.tag = 111
        var present = false
        if topView != nil{
            for (_,subView) in topView!.subviews.enumerated(){
                if subView.tag == 111 || subView.tag == 191 {
                    present = true
                }
            }
        }
        if !present{
            topView?.addSubview(loadingView)
        }
    }
    static func showLoader(_ onView : UIView){
        let topView = onView
        let loadingView = UIView(frame : CGRect(x: 0, y: 0, width: topView.frame.width, height: topView.frame.height))
        loadingView.backgroundColor = UIColor.black
        loadingView.alpha = 0.6
        let laodingFrame = SpinnerView(frame: CGRect(x: topView.frame.width/2 - 20, y: topView.frame.height/2 - 20, width: 40, height: 40))
        loadingView.addSubview(laodingFrame)
        loadingView.tag = 111
        var present = false
        for (_,subView) in topView.subviews.enumerated(){
            if subView.tag == 111 {
                present = true
            }
        }
        if !present{
            topView.addSubview(loadingView)
        }
    }
    
    static func heightForLabel(text:String, width:CGFloat, font : UIFont) -> CGFloat{
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.height
    }
    
    static func decimalPlaceFromFloat(_ num: Float, decimalPlace: Int) -> String{
        return String(format: "%0.\(decimalPlace)f", num)
    }
    
    static func decimalPlaceFromDouble(_ num: Double, decimalPlace: Int) -> String{
        return String(format: "%0.\(decimalPlace)f", num)
    }
    
    static func decimalPlaceFromString(_ num: String, decimalPlace: Int) -> String{
        return String(format: "%0.\(decimalPlace)f", num)
    }
    
    static func checkingTheValues(_ value: inout String)->String {
      if value.contains(".") {
        let notAcceptedChar = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
        let cs = CharacterSet(charactersIn: notAcceptedChar).inverted
        let filtered: String = (value.components(separatedBy: cs) as NSArray).componentsJoined(by: "")
        print(filtered)
        if filtered == "" {
          value = checkingForZero(value.components(separatedBy: ".").first!) + "." + value.components(separatedBy: ".").last!
        if var lastComponent = value.components(separatedBy: ".").last {
          if lastComponent.count > 10 {
            lastComponent.removeLast(lastComponent.count - 10)
            value = value.components(separatedBy: ".").first! + "." + lastComponent
            return value
          }else if lastComponent.count < 10 {
            for _ in 0..<(10-lastComponent.count) {
              lastComponent.append("0")
            }
            value = value.components(separatedBy: ".").first! + "." + lastComponent
            return value
          }else {
            return value
          }
        }
        }else {
          return value
        }
      }else {
        let notAcceptedChar = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
        let cs = CharacterSet(charactersIn: notAcceptedChar).inverted
        let filtered: String = (value.components(separatedBy: cs) as NSArray).componentsJoined(by: "")
        // print(filtered)
        if filtered == "" {
          value = checkingForZero(value)
         let intValue = (value as NSString).integerValue
        if intValue != nil && intValue != 0 {
          var lastComponent = ""
            for _ in 0..<10 {
              lastComponent.append("0")
            }
            value = value.components(separatedBy: ".").first! + "." + lastComponent
            return value
        }else {
          return value
        }
        }else {
          return value
        }
      }
     return value
    }
    
    static func checkingForZero(_ value: String)->String {
       var finalVal = value
        for myVal in Array(value) {
          if myVal == "0" {
            finalVal.removeFirst()
          }else {
            return finalVal
          }
        }
        return finalVal
    }
    
    static func ActionSheet(editPost: @escaping() -> Void, deletePost: @escaping() -> Void) {
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        optionMenu.addAction(UIAlertAction(title: "Mail (Default)", style: .default, handler: { _ in
            editPost()
        }))
        optionMenu.addAction(UIAlertAction(title: "Gmail", style: .default, handler: { _ in
            deletePost()
        }))
        optionMenu.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in }))
        optionMenu.view.tintColor = Colors.btnborderColorbnb.color()
        getTopMostViewController()?.present(optionMenu, animated: true, completion: nil)
        
    }
    
    static func MD5(string: String) -> Data {
        let length = Int(CC_MD5_DIGEST_LENGTH)
        let messageData = string.data(using:.utf8)!
        var digestData = Data(count: length)

        _ = digestData.withUnsafeMutableBytes { digestBytes -> UInt8 in
            messageData.withUnsafeBytes { messageBytes -> UInt8 in
                if let messageBytesBaseAddress = messageBytes.baseAddress, let digestBytesBlindMemory = digestBytes.bindMemory(to: UInt8.self).baseAddress {
                    let messageLength = CC_LONG(messageData.count)
                    CC_MD5(messageBytesBaseAddress, messageLength, digestBytesBlindMemory)
                }
                return 0
            }
        }
        return digestData
    }
    
    
    static func randomString(length: Int) -> String {
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@!@#$%^"
        let len = UInt32(letters.length)
        var randomString = ""
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        return randomString
    }
    
    
    static func settingCountDownTimmer(_ timeString: String, complitionHandler: @escaping(_ day : Int?,_ hour: Int?, _ minutes: Int?)->()) {
        // here we set the current date
        let date = NSDate()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute, .month, .year, .day, .second], from: date as Date)
        let currentDate = calendar.date(from: components)
        let userCalendar = Calendar.current
        // here we set the due date. When the timer is supposed to finish
        let competitionDate = NSDateComponents()
        competitionDate.year = Int((jsonformatDayndMonthDateConvertor(jsonDate: timeString).year as NSString).intValue)
        competitionDate.month = Int((jsonformatDayndMonthDateConvertor(jsonDate: timeString).monthInt as NSString).intValue)
        competitionDate.day = Int((jsonformatDayndMonthDateConvertor(jsonDate: timeString).day as NSString).intValue)
        competitionDate.hour = Int((jsonformatDayndMonthDateConvertor(jsonDate: timeString).hour as NSString).intValue)
        competitionDate.minute = Int((jsonformatDayndMonthDateConvertor(jsonDate: timeString).minutes as NSString).intValue)
        let competitionDay = userCalendar.date(from: competitionDate as DateComponents)!
        //here we change the seconds to hours,minutes and days
        let CompetitionDayDifference = calendar.dateComponents([.day, .hour, .minute, .second], from: currentDate!, to: competitionDay)
        //finally, here we set the variable to our remaining time
        let daysLeft = CompetitionDayDifference.day
        let hoursLeft = CompetitionDayDifference.hour
        let minutesLeft = CompetitionDayDifference.minute
        let secondsLeft = CompetitionDayDifference.second
        print("day:", daysLeft ?? "N/A", "hour:", hoursLeft ?? "N/A", "minute:", minutesLeft ?? "N/A", "Seconds:", secondsLeft ?? "N/A")
        //Set countdown label text
        print("\(daysLeft ?? 0) Days, \(hoursLeft ?? 0) Hours, \(minutesLeft ?? 0) Minutes")
        complitionHandler(daysLeft,hoursLeft,minutesLeft)
    }
     
    static func jsonformatDayndMonthDateConvertor(jsonDate:String)-> (year: String, monthInt: String,day : String, hour:String, minutes:String){
        _ = jsonDate
        let localTime = self.UTCToLocal(date: jsonDate)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let date = dateFormatter.date(from: localTime){
            print(date)
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .weekday], from: date)
            if let finalDate = calendar.date(from:components){
                //MARK:::---This gives month as three letters (Jun, Dec, etc)
                let justMonth = DateFormatter()
                justMonth.dateFormat = "MMM"
                let month = justMonth.string(from: finalDate)
                let justMonthInt = DateFormatter()
                justMonthInt.dateFormat = "MM"
                let montInt = justMonthInt.string(from: finalDate)
                //MARK:::---This gives the day of month, with no preceding 0s (6,14,29)
                let justDay = DateFormatter()
                justDay.dateFormat = "dd"
                let day  = justDay.string(from: finalDate)
                let weekDay = DateFormatter()
                weekDay.dateFormat = "EEE"
                let week  = weekDay.string(from: finalDate)
                print(week)
                // MARK:::--- This Will Give Seperate Year Value
                let justYear = DateFormatter()
                justYear.dateFormat = "yyyy"
                let year = "\(justYear.string(from: finalDate))"
                print(day,month,year)
                let justTime = DateFormatter()
                justTime.dateFormat = "HH:mm"
                _ = justTime.string(from: finalDate)
                let justHour = DateFormatter()
                justHour.dateFormat = "HH"
                let hour = justHour.string(from: finalDate)
                let justMin = DateFormatter()
                justMin.dateFormat = "mm"
                let min = justMin.string(from: finalDate)
                return (year,montInt,day,hour,min)
            }else{
                return ("","","","","")
            }
        }else {
            return ("","","","","")
        }
    }
  
    static func UTCToLocal(date:String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        let dt = dateFormatter.date(from: date)
        dateFormatter.timeZone = NSTimeZone(name: "GMT") as TimeZone?
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.string(from: dt!)
    }
    
    static func getOnlyTime(date:Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        dateFormatter.dateFormat = "h:mm a"
        dateFormatter.timeZone = NSTimeZone.local
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.string(from: date)
    }
    
    
    static func myTimeCalculator(_ myTime:String) -> (min:Int,sec:Int) {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        let time = myTime
        var stopTime = timeFormatter.date(from: time)
        let date = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        let hour = calendar.component(.hour, from: stopTime!)
        let minute = calendar.component(.minute, from: stopTime!)
        stopTime = calendar.date(bySetting: .year, value: year, of: stopTime!)
        stopTime = calendar.date(bySetting: .month, value: month, of: stopTime!)
        stopTime = calendar.date(bySetting: .day, value: day, of: stopTime!)
        stopTime = calendar.date(bySetting: .hour, value: hour, of: stopTime!)
        stopTime = calendar.date(bySetting: .minute, value: minute, of: stopTime!)
        let timeDifference = calendar.dateComponents([.hour, .minute, .second], from: stopTime!, to: date)
        print(timeDifference.second!)
        let min = timeDifference.hour! * 60
        let timeDiff = -(min+timeDifference.minute!)
        let secon = -(timeDifference.second!)
        return (timeDiff,secon)
    }
    
    static func gettingDifferenceInDate(_ dateValue: String)->String {
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
      dateFormatter.locale = NSLocale.current
      dateFormatter.timeZone = TimeZone(abbreviation: "GMT+05:30");
        let date1 = dateFormatter.date(from: dateValue)
//      if date1 == nil {
//        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
//        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+05:30");
//        date1 = dateFormatter.date(from: dateValue)
//      }
      if "\(Calendar.current.component(.day, from: Date()))" == "\(Calendar.current.component(.day, from: date1!))" {
        let diffComponents = Calendar.current.dateComponents([.hour, .minute, .second], from: Date(), to: date1!)
        let hours = diffComponents.hour
        let minutes = diffComponents.minute
        let seconds = diffComponents.second
      if (hours ?? 0) * -1 > 0 {
        return "\((hours ?? 0) * -1) hours ago"
      }
      if (((minutes ?? 0) * -1) ) > 59 {
          return "\(hours ?? 0) hours ago"
        }else if ((minutes ?? 0) * -1) < 1{
          return "\((seconds ?? 0) * -1) seconds ago"
        }else {
          return "\((minutes ?? 0) * -1) minutes ago"
        }
      }else {
        let difference = Calendar.current.dateComponents([.day], from: date1!, to: Date())
      if (difference.day ?? 0) > 1 {
        if (difference.day ?? 0) > 2 {
          return "\(dateValue.toTime(inputFormate: "yyyy-MM-dd'T'HH:mm:ss.SSSZ", outPutFormate: "dd MMM yyyy"))"
        }else {
          return "\(difference.day ?? 0) days ago"
        }
//        return "\(dateValue.toTime(inputFormate: "yyyy-MM-dd HH:mm:ss", outPutFormate: "dd MMM yyyy"))"
      }else {
        if (difference.day ?? 0) == 0 {
          let hour = Calendar.current.dateComponents([.hour], from: Date(), to: date1!).hour
          return "\((hour ?? 0) * -1) hours ago"
        }else {
          return "\(difference.day ?? 0) day ago"
        }
        }
      }
    }
}

extension String{
    public func toTime(inputFormate:String,outPutFormate:String)->String{
      var finalstring = ""
      let InputdateForamte = DateFormatter()
      InputdateForamte.dateFormat = inputFormate
      let outputdateForamte = DateFormatter()
      outputdateForamte.dateFormat = outPutFormate
      if let inputdate = InputdateForamte.date(from: self){
        finalstring = outputdateForamte.string(from: inputdate)
      }
      return finalstring
    }
}

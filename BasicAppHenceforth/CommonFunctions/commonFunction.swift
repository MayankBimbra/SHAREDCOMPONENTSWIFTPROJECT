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
            imgVw.image = img?.imageWithInsets(insets: UIEdgeInsets(top: 12, left: 6, bottom: 0, right: 6))?.withRenderingMode(.alwaysTemplate)
            imgVw.tintColor = UIColor.themeColor
            tf.rightView = imgVw
            tf.rightViewMode = .always
        }
    }
    
    static func errorSkyTF(_ tf : SkyFloatingLabelTextField, img: UIImage?, placeHolder : String){
        tf.textColor = UIColor.errorColor
        tf.lineColor = UIColor.errorColor
        tf.tintColor = UIColor.errorColor
        tf.titleColor = UIColor.errorColor
        tf.titleErrorColor = UIColor.errorColor
        tf.selectedTitleColor = UIColor.errorColor
        tf.selectedLineColor = UIColor.errorColor
        tf.lineErrorColor = UIColor.errorColor
        tf.placeholderColor = UIColor.errorColor
        
        tf.lineHeight = 1
        tf.selectedLineHeight = 1
        
        tf.placeholder = placeHolder
        
        tf.font = UIFont.MontserratMedium(Size.Medium.sizeValue())
        tf.titleFont = UIFont.MontserratMedium(Size.Small.sizeValue())
        tf.placeholderFont = UIFont.MontserratMedium(Size.Medium.sizeValue())
            
        if img != nil{
            let imgVw = UIImageView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
            imgVw.contentMode = .bottom
            imgVw.image = img?.imageWithInsets(insets: UIEdgeInsets(top: 12, left: 6, bottom: 0, right: 6))?.withRenderingMode(.alwaysTemplate)
            imgVw.tintColor = UIColor.errorColor
            tf.rightView = imgVw
            tf.rightViewMode = .always
        }
    }
    
    static func normalSkyTFBtn(_ tf : SkyFloatingLabelTextField, btn: UIButton, placeHolder : String){
        
        tf.disableAutoFill()
        
        let img1 = Asset.ic_eye_review.image().imageWithInsets(insets: UIEdgeInsets(top: 12, left: 6, bottom: 0, right: 6))?.withRenderingMode(.alwaysTemplate)
        let img2 = Asset.ic_hideeye_review.image().imageWithInsets(insets: UIEdgeInsets(top: 12, left: 6, bottom: 0, right: 6))?.withRenderingMode(.alwaysTemplate)

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
    
    static func errorSkyTFBtn(_ tf : SkyFloatingLabelTextField, btn: UIButton, placeHolder : String){
        
        tf.disableAutoFill()
        
        let img1 = Asset.ic_eye_review.image().imageWithInsets(insets: UIEdgeInsets(top: 12, left: 6, bottom: 0, right: 6))?.withRenderingMode(.alwaysTemplate)
        let img2 = Asset.ic_hideeye_review.image().imageWithInsets(insets: UIEdgeInsets(top: 12, left: 6, bottom: 0, right: 6))?.withRenderingMode(.alwaysTemplate)

        tf.textColor = UIColor.errorColor
        tf.lineColor = UIColor.errorColor
        tf.tintColor = UIColor.errorColor
        tf.titleColor = UIColor.errorColor
        tf.titleErrorColor = UIColor.errorColor
        tf.selectedTitleColor = UIColor.errorColor
        tf.selectedLineColor = UIColor.errorColor
        tf.lineErrorColor = UIColor.errorColor
        tf.placeholderColor = UIColor.errorColor
        
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
        btn.tintColor = UIColor.errorColor
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
    
    static func logout(_ isLogout : Bool = true){
        var vc : UIViewController!
        if isLogout{
            vc = LoginVC.instantiateFromAppStoryboard(appStoryboard: AppStoryboard.Main)
        }else{
            vc = SignUpVC.instantiateFromAppStoryboard(appStoryboard: AppStoryboard.Main)
        }
        CommonFunctions.getNavigationController().viewControllers.insert(vc, at: 0)
        CommonFunctions.getNavigationController().popToRootViewController(animated: false)
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
    
    static func isValidPassword(_ checkpass:String) -> Bool{
        let passwordCheck = "(?=.*[A-Z])(?=.*[d$@$!%*?&#.><,)/+*(])(?=.*[0-9])(?=.*[a-z]).{8,}"
        let password = NSPredicate(format:"SELF MATCHES %@", passwordCheck)
        return password.evaluate(with: checkpass)
    }
    
    static func isValidPhoneNumber(_ checkphone:String) -> Bool{
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
    
    static func getImage(_ name : String, quality: Image_Quality) -> String{
        if name == ""{
            return ""
        }else{
            return "\(appConstantURL().BASE_URL)image?filename=\(name)\(quality.rawValue)"
        }
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

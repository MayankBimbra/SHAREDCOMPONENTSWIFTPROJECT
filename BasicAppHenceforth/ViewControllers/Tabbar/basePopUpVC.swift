//
//  basePopUpVC.swift
//  BasicAppHenceforth
//
//  Created by NegiMac on 22/12/20.
//

import UIKit

enum AnimationType {
    case zoomOutAnimation
    case zoomInAnimation
    case topInAnimation
    case topOutAnimation
}

class basePopUpVC: UIViewController {

    // MARK: - UI COMPONENTS
    var backVw : UIView?
    var popVw : UIView?
    var middleConst: NSLayoutConstraint?

    
    // MARK: - VARIABLES
    var animationType : AnimationType = .zoomInAnimation

    override func viewDidLoad() {
        super.viewDidLoad()

        backVw!.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapActClose(_:)))
        backVw!.addGestureRecognizer(tapGesture)

        showAnimate()

        // Do any additional setup after loading the view.
    }

    @objc func tapActClose(_ sender: UITapGestureRecognizer){
        stopAnimation()
    }
}

// MARK: - ANIMATIONS
extension basePopUpVC{
    func showAnimate() {
        if animationType == .zoomOutAnimation{
            zoomOutAnimationShow()
        }else if animationType == .zoomInAnimation{
            zoomInAnimationShow()
        }else if animationType == .topInAnimation{
            topInAnimationShow()
        }else if animationType == .topOutAnimation{
            topUpAnimationShow()
        }
        
    }
    
    func stopAnimation() {
        if animationType == .zoomOutAnimation{
            zoomOutAnimationHide()
        }else if animationType == .zoomInAnimation{
            zoomInAnimationHide()
        }else if animationType == .topInAnimation{
            topInAnimationHide()
        }else if animationType == .topOutAnimation{
            topUpAnimationHide()
        }
    }
}


// MARK: - ZOOM OUT
extension basePopUpVC{
    fileprivate func zoomOutAnimationShow(){
        self.popVw!.transform = CGAffineTransform(scaleX: 0.02, y: 0.02)
        //
        self.view.alpha = 0.0
        UIView.animate(withDuration: 0.02, animations: {
            self.view.alpha = 1.0
        }) { _ in
            UIView.animate(withDuration: 0.3, animations: {
                //
                self.popVw!.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            }) { _ in
                UIView.animate(withDuration: 0.2, animations: {
                    self.popVw!.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                })
            }
        }
    }

    fileprivate func zoomOutAnimationHide(){
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0, options: [], animations: {
                        self.popVw!.transform = CGAffineTransform(scaleX: 0.02, y: 0.02)
        }) { (success) in
            self.view.removeFromSuperview()
        }
    }
}


// MARK: - ZOOM IN
extension basePopUpVC{
    fileprivate func zoomInAnimationShow(){
        self.popVw!.transform = CGAffineTransform(scaleX: 10, y: 10)
        //
        self.view.alpha = 0.0
        self.popVw!.alpha = 0.0
        UIView.animate(withDuration: 0.02, animations: {
            self.view.alpha = 1.0
        }) { _ in
            UIView.animate(withDuration: 0.3, animations: {
                //
                self.popVw!.alpha = 1.0
                self.popVw!.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            }) { _ in
                UIView.animate(withDuration: 0.2, animations: {
                    self.popVw!.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                })
            }
        }
    }
        
    fileprivate func zoomInAnimationHide(){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0, options: [], animations: {
            self.popVw!.transform = CGAffineTransform(scaleX: 2, y: 2)
            self.view.alpha = 0.0
        }) { (success) in
            self.view.removeFromSuperview()
        }
    }
}


// MARK: - TOP IN
extension basePopUpVC{
    fileprivate func topInAnimationShow(){
        self.middleConst!.constant = -600
        self.view.layoutIfNeeded()
        self.view.alpha = 0.0
        UIView.animate(withDuration: 0.02, animations: {
            self.view.alpha = 1.0
        }) { _ in
            self.middleConst!.constant = 20
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            }) { _ in
                self.middleConst!.constant = 0
                UIView.animate(withDuration: 0.2, animations: {
                    self.view.layoutIfNeeded()
                })
            }
        }
    }
        
    fileprivate func topInAnimationHide(){
        self.middleConst!.constant = 600
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.view.removeFromSuperview()
        }
    }
}

// MARK: - TOP UP
extension basePopUpVC{
    fileprivate func topUpAnimationShow(){
        self.middleConst!.constant = 600
        self.view.layoutIfNeeded()
        self.view.alpha = 0.0
        UIView.animate(withDuration: 0.02, animations: {
            self.view.alpha = 1.0
        }) { _ in
            self.middleConst!.constant = -20
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            }) { _ in
                self.middleConst!.constant = 0
                UIView.animate(withDuration: 0.2, animations: {
                    self.view.layoutIfNeeded()
                })
            }
        }
    }
        
    fileprivate func topUpAnimationHide(){
        self.middleConst!.constant = -600
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.view.removeFromSuperview()
        }
    }
}

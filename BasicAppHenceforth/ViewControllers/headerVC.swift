//
//  headerVC.swift
//  BasicAppHenceforth
//
//  Created by NegiMac on 20/12/20.
//

import UIKit

/// Control all headers of screen
class headerVC: UIViewController {

    public var isBackEnabled = false
    
    fileprivate lazy var viewHeader : UIView = {
        let vw = UIView()
        vw.backgroundColor = UIColor.themeColor
        return vw
    }()
    
    public lazy var lblHeader : UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.appWhiteColor
        lbl.font = UIFont.MontserratMedium(Size.XLarge.sizeValue())
        return lbl
    }()
    
    fileprivate lazy var btnBack : UIButton = {
        let btn = UIButton()
        let img = Asset.ic_back.image().withRenderingMode(.alwaysTemplate)
        btn.setImage(img, for: .normal)
        btn.tintColor = UIColor.appWhiteColor
        btn.contentEdgeInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        return btn
    }()
    
    public lazy var btnRight : UIButton = {
        let btn = UIButton()
        btn.tintColor = UIColor.appWhiteColor
        btn.contentEdgeInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        btn.setTitleColor(UIColor.appWhiteColor, for: .normal)
        btn.titleLabel?.font = UIFont.MontserratSemiBold(Size.Medium.sizeValue())
//        btn.isHidden = true
        return btn
    }()

    
    // MARK: - OVERRIDE FUNCTIONS
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
}


// MARK: - SET UP UI
extension headerVC{
    fileprivate func setUpUI(){
        self.view.addSubview(viewHeader)
        viewHeader.addSubview(lblHeader)
        viewHeader.addSubview(btnBack)
        viewHeader.addSubview(btnRight)

        viewHeader.translatesAutoresizingMaskIntoConstraints = false
        lblHeader.translatesAutoresizingMaskIntoConstraints = false
        btnBack.translatesAutoresizingMaskIntoConstraints = false
        btnRight.translatesAutoresizingMaskIntoConstraints = false

        viewHeader.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        viewHeader.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        viewHeader.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true

        lblHeader.leftAnchor.constraint(equalTo: btnBack.rightAnchor).isActive = true
        lblHeader.centerYAnchor.constraint(equalTo: btnBack.centerYAnchor).isActive = true

        btnBack.leftAnchor.constraint(equalTo: viewHeader.leftAnchor, constant: isBackEnabled ? 0 : -36).isActive = true
        btnBack.bottomAnchor.constraint(equalTo: viewHeader.bottomAnchor).isActive = true
        btnBack.topAnchor.constraint(equalTo: viewHeader.topAnchor, constant: topStatusHeight).isActive = true

        btnRight.rightAnchor.constraint(equalTo: viewHeader.rightAnchor).isActive = true
        btnRight.bottomAnchor.constraint(equalTo: viewHeader.bottomAnchor).isActive = true
        btnRight.topAnchor.constraint(equalTo: btnBack.topAnchor).isActive = true
        
        btnBack.isHidden = !isBackEnabled
        
        btnBack.addTarget(self, action: #selector(btnActBack(_:)), for: .touchUpInside)
    }
}


// MARK: - EXTERNAL FUNCTIONS
extension headerVC{
    @objc func btnActBack(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
}

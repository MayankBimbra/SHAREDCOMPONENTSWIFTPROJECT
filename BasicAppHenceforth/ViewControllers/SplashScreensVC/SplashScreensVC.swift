//
//  ViewController.swift
//  BasicAppHenceforth
//
//  Created by Think Recycling Pvt Ltd on 24/11/20.
//

import UIKit

struct SplashScreenData {
    var title : String!
    var subTitle : String!
    var image : UIImage?
    var imageLink : String?
    
    init(_ title: String, _ subTitle: String, _ img: UIImage?, _ imgLink: String?) {
        self.title = title
        self.subTitle = subTitle
        self.image = img
        self.imageLink = imgLink
    }
}


class SplashScreensVC: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var btnSkip: UIButton!
    @IBOutlet weak var btnRegister: UIButton!
    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var collView: UICollectionView!{
        didSet{
            collView.delegate = self
            collView.dataSource = self
        }
    }
    @IBOutlet var stackViews: [UIView]!
    @IBOutlet var widthConsts: [NSLayoutConstraint]!
    
    
    // MARK: - VARIABLES
    var currentSelectedPage = 0
    var pages : [SplashScreenData] = [
        SplashScreenData(L10n.Splash1Header.description, L10n.Splash1Detail.description, Asset.ic_splash1.image(), nil),
        SplashScreenData(L10n.Splash2Header.description, L10n.Splash2Detail.description, Asset.ic_splash2.image(), nil),
        SplashScreenData(L10n.Splash3Header.description, L10n.Splash3Detail.description, Asset.ic_splash3.image(), nil)
    ]
    
    
    // MARK: - OVERRIDE FUNCTIONS
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        // Do any additional setup after loading the view.
    }
}


// MARK: - SETUP UI
extension SplashScreensVC{
    func setUpUI(){
        collView.contentInsetAdjustmentBehavior = .never
        if #available(iOS 13.0, *) {
            collView.automaticallyAdjustsScrollIndicatorInsets = false
        } else {
            // Fallback on earlier versions
        }
        
        btnSkip.titleLabel?.font = UIFont.MontserratSemiBold(Size.Medium.sizeValue())
        btnRegister.titleLabel?.font = UIFont.NexaBold(Size.Large.sizeValue())
        btnSignIn.titleLabel?.font = UIFont.NexaBold(Size.Large.sizeValue())
        
        btnSkip.setTitle(L10n.SKIP.description, for: .normal)
        btnRegister.setTitle(L10n.REGISTER.description, for: .normal)
        btnSignIn.setTitle(L10n.SIGNIN.description, for: .normal)

        btnRegister.addTarget(self, action: #selector(btnActRegister(_:)), for: .touchUpInside)
        btnSignIn.addTarget(self, action: #selector(btnActSignIn(_:)), for: .touchUpInside)
        btnSkip.addTarget(self, action: #selector(btnActSkip(_:)), for: .touchUpInside)

        btnRegister.layer.cornerRadius = btnRegister.frame.height/2
        btnSignIn.layer.cornerRadius = btnSignIn.frame.height/2
        btnSignIn.layer.borderWidth = 1
        btnSignIn.layer.borderColor = UIColor.themeColor.cgColor
        for (kNum, vw) in stackViews.enumerated(){
            if pages.count > kNum{
                stackViews[kNum].isHidden = false
            }else{
                stackViews[kNum].isHidden = true
            }
            if kNum == 0{
                vw.backgroundColor = UIColor.themeColor
                widthConsts[kNum].constant = 26
            }else{
                vw.backgroundColor = UIColor.themeUnSelectedColor
                widthConsts[kNum].constant = 14
            }
            vw.layer.cornerRadius = 3
        }
    }
    
    func setPageControls(_ num: Int){
        if currentSelectedPage == num{
            return
        }
        currentSelectedPage = num
        if num == pages.count - 1{
            btnSkip.isHidden = true
        }else{
            btnSkip.isHidden = false
        }
        for (kNum, vw) in stackViews.enumerated(){
            if kNum == num{
                vw.backgroundColor = UIColor.themeColor
                widthConsts[kNum].constant = 26
            }else{
                vw.backgroundColor = UIColor.themeUnSelectedColor
                widthConsts[kNum].constant = 14
            }
        }
    }
}


// MARK: - COLLECTION VIEW FUNCTIONS
extension SplashScreensVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.SplashScreenCVC.getValues(), for: indexPath) as! SplashScreenCVC
        cell.setData(pages[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let value = (scrollView.contentOffset.x + scrollView.frame.width/2)/scrollView.frame.width
        self.setPageControls(Int(value))
    }
}


// MARK: - EXTERNAL FUNCTIONS
extension SplashScreensVC{
    @objc func btnActRegister(_ sender: UIButton){
        let vc = SignUpVC.instantiateFromAppStoryboard(appStoryboard: .Main)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func btnActSignIn(_ sender: UIButton){
        let vc = LoginVC.instantiateFromAppStoryboard(appStoryboard: .Main)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func btnActSkip(_ sender: Any) {
        if currentSelectedPage == 0{
            collView.scrollToItem(at: IndexPath(item: 1, section: 0), at: [.centeredHorizontally, .centeredVertically], animated: true)
        }else if currentSelectedPage == 1{
            collView.scrollToItem(at: IndexPath(item: 2, section: 0), at: [.centeredHorizontally, .centeredVertically], animated: true)
        }else{
            
        }
    }
}

//
//  ViewController.swift
//  BasicAppHenceforth
//
//  Created by Think Recycling Pvt Ltd on 24/11/20.
//

import UIKit

class SplashScreensVC: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnSkip: UIButton!
    @IBOutlet var subView: [UIView]!
    
    // MARK: - VARIABLES
    var currentSelectedPage = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setDataViewDidLoad()
        // Do any additional setup after loading the view.
    }

    //MARK: Button Actions
    @IBAction func btnActSkip(_ sender: Any) {
        let vc = SignUpVC.instantiateFromAppStoryboard(appStoryboard: .Main)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnActNext(_ sender: UIButton) {
        sender.isUserInteractionEnabled = false
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            sender.isUserInteractionEnabled = true
        }
        if currentSelectedPage == 0{
            self.selectedPage(1)
            scrollView.setContentOffset(CGPoint(x: scrollView.frame.width, y: 0), animated: true)
        }else if currentSelectedPage == 1{
            self.selectedPage(2)
            scrollView.setContentOffset(CGPoint(x: 2*scrollView.frame.width, y: 0), animated: true)
        }else{
            let vc = SignUpVC.instantiateFromAppStoryboard(appStoryboard: .Main)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

//MARK:- SetUp UI
extension SplashScreensVC{
    func setDataViewDidLoad(){
        btnNext.layer.cornerRadius = 22
        scrollView.contentInsetAdjustmentBehavior = .never
        if #available(iOS 13.0, *) {
            scrollView.automaticallyAdjustsScrollIndicatorInsets = false
        } else {
            // Fallback on earlier versions
        }
    }
}

extension SplashScreensVC {
    
    func updateDots() {
    }        
}

// MARK: - LOGICAL FUNCTIONS
extension SplashScreensVC{
    func selectedPage(_ num : Int){
        if currentSelectedPage != num{
            if num == 2{
                btnNext.setTitle("Start", for: .normal)
                btnSkip.isHidden = true
            }else{
                btnNext.setTitle("Next", for: .normal)
                btnSkip.isHidden = false
            }
            currentSelectedPage = num
            pageControl.currentPage = currentSelectedPage
        }
    }
}

// MARK: - SCROLL VIEW DELEGATE FUCNTIONS
extension SplashScreensVC: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x < scrollView.frame.width/2{
            self.selectedPage(0)
        }else if scrollView.contentOffset.x < 3*scrollView.frame.width/2{
            self.selectedPage(1)
        }else {
            self.selectedPage(2)
        }
    }
}

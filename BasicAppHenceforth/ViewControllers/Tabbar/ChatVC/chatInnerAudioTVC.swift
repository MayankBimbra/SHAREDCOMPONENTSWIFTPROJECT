//
//  chatInnerAudioTVC.swift
//  BasicAppHenceforth
//
//  Created by NegiMac on 02/01/21.
//

import UIKit

class chatBaseAudioTVC: chatBaseTVC {
    
    var imgViewBaseDP : UIImageView!
    var btnBasePlay : UIButton!
    var sliderBaseAudio : UISlider!
    var lblBaseTime : UILabel!
    
    var showColor : UIColor!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgViewBaseDP.layer.cornerRadius = imgViewBaseDP.frame.height/2
        imgViewBaseDP.backgroundColor = UIColor.textColorPlaceholder

        lblBaseTime.font = UIFont.MontserratSemiBold(Size.VSmall.sizeValue())
        lblBaseTime.textColor = UIColor.textColorTwo

        let circleImage = makeCircleWith(size: CGSize(width: 12, height: 12),
                                         backgroundColor: showColor)
        sliderBaseAudio.setThumbImage(circleImage, for: .normal)
        sliderBaseAudio.setThumbImage(circleImage, for: .highlighted)
        sliderBaseAudio.setValue(0, animated: false)
        sliderBaseAudio.isUserInteractionEnabled = false
        
        ifPlaying(false)
        btnBasePlay.tintColor = showColor
    }    
    
    func ifPlaying(_ isPlaying: Bool){
        if isPlaying{
            btnBasePlay.setImage(Asset.ic_pause.image().withRenderingMode(.alwaysTemplate),
                                 for: .normal)
        }else{
            btnBasePlay.setImage(Asset.ic_play_audio.image().withRenderingMode(.alwaysTemplate),
                                 for: .normal)
        }
    }
    
    fileprivate func makeCircleWith(size: CGSize, backgroundColor: UIColor) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(backgroundColor.cgColor)
        context?.setStrokeColor(UIColor.clear.cgColor)
        let bounds = CGRect(origin: .zero, size: size)
        context?.addEllipse(in: bounds)
        context?.drawPath(using: .fill)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

class chatInnerAudioLeftTVC: chatBaseAudioTVC {

    @IBOutlet weak var imgViewDP: UIImageView!
    @IBOutlet weak var btnPlay: UIButton!
    @IBOutlet weak var sliderAudio: UISlider!
    @IBOutlet weak var lblTime: UILabel!
    
    
    override func awakeFromNib() {
        imgViewBaseDP = imgViewDP
        btnBasePlay = btnPlay
        sliderBaseAudio = sliderAudio
        lblBaseTime = lblTime
        showColor = UIColor.textColorTwo
        super.awakeFromNib()
        lblTime.text = "10:00AM"
    }
}


class chatInnerAudioRightTVC: chatBaseAudioTVC {
    
    @IBOutlet weak var imgViewDP: UIImageView!
    @IBOutlet weak var btnPlay: UIButton!
    @IBOutlet weak var sliderAudio: UISlider!
    @IBOutlet weak var lblTime: UILabel!
    
    override func awakeFromNib() {
        imgViewBaseDP = imgViewDP
        btnBasePlay = btnPlay
        sliderBaseAudio = sliderAudio
        lblBaseTime = lblTime
        showColor = UIColor.appWhiteColor
        super.awakeFromNib()
        lblTime.text = "10:00AM"
    }
}

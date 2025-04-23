//
//  LanchScreenView.swift
//  Crazy Hero
//
//  Created by 7x on 2023/12/19.
//

import UIKit
import SnapKit
class LanchScreenView: UIView {
    
    var type = 0
    var time = 0.5
    private let bgImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "launchScreen_bg")
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "launchScreen_logo")
        return imageView
    }()
    
    private let topImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "launch_bg_top")
        return imageView
    }()
    
    private let bouttomImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "launch_bg_bouttom")
        return imageView
    }()
    
    private let progressBgViwe: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.init(named:"progress_lanch_bg")
        return imageView
    }()
    
    let progressViwe: UIProgressView = {
        let progressView = UIProgressView()
        progressView.progressViewStyle = .bar
        progressView.progressImage = UIImage.init(named: "progress_lanch_bg1")
        return progressView
    }()
    
    let progressLabel: UILabel = {
        let label = UILabel()
        label.text = "0%"
        label.textAlignment = .center
        label.font = UIFont.init(style: .ARIALBold, size: 17)
        label.textColor = UIColor(hexString: "#ffffff")
        label.addStroke(color: UIColor(hexString: "#000000") ?? UIColor.black, width: -5.0)
        return label
    }()
    
    
    private var timer: Timer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
            
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        addSubview(bgImage)
        addSubview(topImageView)
        addSubview(bouttomImageView)
        addSubview(logoImageView)
        addSubview(progressBgViwe)
        progressBgViwe.addSubview(progressViwe)
        progressBgViwe.addSubview(progressLabel)
        
        bgImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        topImageView.snp.makeConstraints { make in
            make.top.equalTo(self)
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.height.equalTo(topImageView.image?.size.height ?? 0)
        }
        
        bouttomImageView.snp.makeConstraints { make in
            make.bottom.equalTo(self)
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.height.equalTo(bouttomImageView.image?.size.height ?? 0)
        }
        
        logoImageView.snp.makeConstraints { make in
            make.top.equalTo(self).offset(100.uiX)
            make.left.equalTo(self).offset(20.uiX)
            make.right.equalTo(self).offset(-20.uiX)
            make.height.equalTo(logoImageView.image?.size.height ?? 0)
        }
        
        progressBgViwe.snp.makeConstraints { make in
            make.bottom.equalTo(self).offset(-160.uiX)
            make.left.equalTo(self).offset(50.uiX)
            make.right.equalTo(self).offset(-50.uiX)
            make.height.equalTo(32)
        }
        
        progressViwe.snp.makeConstraints { make in
            make.left.equalTo(progressBgViwe).offset(5)
            make.right.equalTo(progressBgViwe).offset(-5)
            make.top.equalTo(progressBgViwe).offset(5)
            make.bottom.equalTo(progressBgViwe).offset(-6)
        }
        
        progressLabel.snp.makeConstraints { make in
            make.centerY.equalTo(progressBgViwe.snp.centerY)
            make.left.equalTo(progressBgViwe).offset(12)
            make.right.equalTo(progressBgViwe).offset(-12)
            make.height.equalTo(16)
        }
        
        timer = Timer.scheduledTimer(timeInterval: time, target: self, selector: #selector(updateProgressView), userInfo: nil, repeats: true)
    }
    
    @objc private func updateProgressView() {

        var progress = progressViwe.progress
        switch type {
        case 0:
            if(progress >= 0.7){
                progress = 0.7
                progressViwe.progress = progress
                progressLabel.text = "70%"
            }
            break
        case 1:
//            if(progress >= 0.79){
                progress = 0.8
                
//            }
            progressViwe.progress = progress
            progressLabel.text = "80%"
            return
        case 2:
//            if(progress >= 0.89){
                progress = 0.9
//            }
            time = 0.1
            progressViwe.progress = progress
            progressLabel.text = "90%"
        case 3:
//            if(progress >= 0.99){
                progress = 1
//            }
            progressViwe.progress = progress
            progressLabel.text = "100%"
        default:
            break
        }
        if progressViwe.progress <= 0.3 {
            progressLabel.text = "30%"
            progressViwe.progress = 0.3
            progress = progressViwe.progress
        }
        else if progressViwe.progress >= 1.0 {

            progressLabel.text = "99%"
            timer?.invalidate()
            timer = nil
        } else {
            progressLabel.text = String(format: "%.0f%%", progressViwe.progress * 100)
        }
        progressViwe.setProgress(progress + 0.02, animated: true)
    }
    
    deinit {
        timer?.invalidate()
        timer = nil
    }
    
}

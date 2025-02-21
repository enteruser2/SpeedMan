//
//  WebViewController.swift
//  CrazyBird
//
//  Created by 7x on 2024/3/7.
//

import RxCocoa
import RxSwift
import UIKit
import WebKit


protocol webViewDelegate: AnyObject {
    
    func webViewDissmiss(uuid:String)
    
}

class WebViewController: BaseViewController,WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
        if(message.name == "bindSuc")
        {
            self.navigationController?.popViewController(animated: true)
            self.delegate?.webViewDissmiss(uuid: message.body as! String)
        }
        
    }
    
    // MARK: - Fields
    var webView: WKWebView?

    var delegate: webViewDelegate?

    private lazy var progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.progressTintColor = UIColor(hexString: "#1AAB97")
        progressView.trackTintColor = .clear
        return progressView
    }()

    private var disposeBag = DisposeBag()

    var url: URL?
    var needGoBack = false
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        guard let navigationController = navigationController else {
            return
        }
        progressView.frame = CGRect(x: 0, y: UIDevice.navigationBarHeight - progressView.frame.size.height, width: navigationController.navigationBar.frame.size.width, height: progressView.frame.size.height)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let webConfiguration = WKWebViewConfiguration()
        let preferences = WKPreferences()
        preferences.javaScriptEnabled = true
        webConfiguration.preferences = preferences
        let userContentController = WKUserContentController()
        webConfiguration.userContentController = userContentController
        // 给WKWebView与Swift交互起一个名字：callback
        webConfiguration.userContentController.add(self, name: "bindSuc")
        let webView = WKWebView(frame:CGRect(x: 0, y: UIDevice.navigationBarHeight, width:UIDevice.screenWidth, height: UIDevice.screenHeight), configuration: webConfiguration)

        webView.allowsBackForwardNavigationGestures = true
        webView.isMultipleTouchEnabled = true

        self.webView = webView
        view.addSubview(self.webView!)

        setupUI()
        setupBinding()
        setupData()
    }

    // MARK: - Setup

    private func setupUI() {
        if navigationController?.viewControllers.count ?? 0 <= 1 {
            navigationItem.leftBarButtonItem = nil
        }
//        navigationController?.navigationBar.addSubview(progressView)
        self.view.addSubview(progressView)
    }

    private func setupData() {
        if let url = url {
            load(url)
        }
    }

    override func setupBinding() {
        super.setupBinding()
        guard let webView = webView else {
            return
        }
        if needGoBack {
            webView.rx.canGoBack.bind {[weak self] canGoBack in
                guard let self = self else { return }
                if canGoBack {
                    let backBtn = UIButton()
                    backBtn.rx.tap.subscribe(onNext: {[weak self] _ in
                        guard let self = self else { return }
                        self.webView?.goBack()
                    }).disposed(by: backBtn.rx.disposeBag)
                    backBtn.setImage(UIImage(named: "back_icon"), for: .normal)
                    backBtn.frame = .init(x: 0, y: 0, width: 40, height: 40)
                    backBtn.contentHorizontalAlignment = .left
                    self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)
                } else {
                    self.navigationItem.leftBarButtonItem = nil
                }
            }.disposed(by: disposeBag)
        }
//        webView.rx.title.bind(to: navigationItem.rx.title).disposed(by: disposeBag)
        webView.rx.estimatedProgress.bind { [weak self] estimatedProgress in
            self?.progressView.alpha = 1
            self?.progressView.setProgress(Float(estimatedProgress), animated: true)

            if estimatedProgress >= 1.0 {
                UIView.animate(withDuration: 0.3, delay: 0.3, options: .curveEaseOut, animations: { [weak self] in
                    self?.progressView.alpha = 0
                    }, completion: { [weak self] _ in
                        self?.progressView.setProgress(0, animated: false)
                })
            }
        }.disposed(by: disposeBag)
        webView.rx.didFailLoad.bind { (navigation, error) in
            CommonTool.LogLine(message: "\(error)")
        }.disposed(by: disposeBag)
        webView.rx.didFinishLoad.bind { (navigation) in
            CommonTool.LogLine(message: "..... success ....")
        }.disposed(by: disposeBag)
    }

    private func load(_ url: URL) {
        guard let webView = webView else {
            return
        }
        let request = URLRequest(url: url)
        DispatchQueue.main.async {
            webView.load(request)
        }
    }
}

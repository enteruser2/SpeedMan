//
//  TabBarController.swift
//  WallPaper
//
//  Created by LiQi on 2020/4/9.
//  Copyright © 2020 Qire. All rights reserved.
//

import UIKit
import NSObject_Rx
import Hue
import RxSwift
import RxCocoa

enum TabBarItem: Int {
    case discover
    case square
    case cam
    case message
    case me
}

extension Notification.Name {
    
    static let TabItemClicked = NSNotification.Name(rawValue: "tabItemClicked")
    
}

protocol TabBarControllerDelegate: AnyObject {
    
    func showChildControllers(tabController: TabBarController, items: [TabBarItem])
    func tabBarSelectedMessage(tabController: TabBarController, userId: String)
    
}

class TabBarController: UITabBarController {
    
    let scrollToTopStatus = BehaviorRelay<Bool>(value: true)
    let scrollToTop = PublishRelay<Void>()
    
    @objc
    static let SquareUnreadNumNotice = NSNotification.Name(rawValue: "SquareUnreadNumNotice")
    
    let viewModel = TabBarViewModel()
    weak var itemDelegate: TabBarControllerDelegate?
    
    private var bar: TabBar!
    
    init(itemDelegate: TabBarControllerDelegate) {
        self.itemDelegate = itemDelegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBinding()
        NotificationCenter.default.addObserver(self, selector: #selector(getNoReadNum(no:)), name: NSNotification.Name(rawValue: TUIKitNotification_onChangeUnReadCount), object: nil)
        V2TIMManager.sharedInstance()?.getConversationList(0, count: Int32.max, succ: {[weak self] (list, _, _) in
            guard let self = self else { return }
            var unRead = 0
            list?.forEach { m in
                unRead += Int(m.unreadCount)
            }
            self.setupNumber(n: unRead)
        }, fail: nil)
        YBBlackListManager.shared.loadBlackList()
        
        PushManager.shared.pushChat.subscribe(onNext: {[weak self] userId in
            guard let self = self else { return }
            self.itemDelegate?.tabBarSelectedMessage(tabController: self, userId: userId)
        }).disposed(by: rx.disposeBag)
                
        SquareManager.shared.squareUnreadNum.subscribe(onNext: {model in
            if let model = model {
                Application.shared.tabBarController?.squareNumber = model.unreadMessagesCount
            }
        }).disposed(by: self.rx.disposeBag)
        
        SquareManager.shared.getSubjectTotal().subscribe(onSuccess: nil, onError: nil).disposed(by: self.rx.disposeBag)
        
        YBRemarkManager.shared.loadList()

    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return selectedViewController?.preferredStatusBarStyle ?? .lightContent
    }
    
    @objc
    private func getNoReadNum(no: Notification) {
        var unRead = 0
        if let arr = no.object as? Array<V2TIMConversation> {
            arr.forEach { m in
                unRead += Int(m.unreadCount)
            }
        }
        setupNumber(n: unRead)
    }
    
    private func freshNumber(n: Int) {
        SquareManager.shared.getSubjectTotal().subscribe(onSuccess: nil, onError: nil).disposed(by: self.rx.disposeBag)
    }

    
    private func setupNumber(n: Int) {
        if n != 0 {
            bar.messageLbl.text = "\(n)"
            bar.messageLbl.isHidden = false
        } else {
            bar.messageLbl.isHidden = true
        }
    }
    
    var squareNumber: Int {
        set {
            bar.squareLbl.text = "\(newValue)"
            if newValue != 0 {
                bar.squareLbl.isHidden = false
            } else {
                bar.squareLbl.isHidden = true
            }
        }
        get {
            bar.squareLbl.text?.int ?? 0
        }
    }

    // MARK: - Setup
    
    private func setupUI() {
        
        bar = TabBar(frame: .zero)
        
        let gr1 = [UIColor(hex: "#7B30EE"), UIColor(hex: "#BE56FF")].gradient()
        gr1.startPoint = .init(x: 0, y: 0)
        gr1.endPoint = .init(x: 1, y: 0)
        gr1.frame = .init(x: 0, y: 0, width: UIDevice.screenWidth, height: UIDevice.tabarBarHeight)
        let img = UIImage.imageWithLayer(layer: gr1)
        
        let att: [NSAttributedString.Key : Any] = [
            .font : UIFont(style: .regular, size: 9),
            .foregroundColor : UIColor.white
        ]
        let normalAtt: [NSAttributedString.Key : Any] = [
            .font : UIFont(style: .regular, size: 9),
            .foregroundColor : UIColor(hex: "#CA9FFF")
        ]
        
        UITabBarItem.appearance().setTitleTextAttributes(att, for: .selected)
        UITabBarItem.appearance().setTitleTextAttributes(normalAtt, for: .normal)
        if #available(iOS 13, *) {
            let appearance = self.tabBar.standardAppearance.copy()
            appearance.shadowImage = UIImage()
            appearance.backgroundColor = .clear
            appearance.backgroundImage = img
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = normalAtt
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = att
            appearance.inlineLayoutAppearance.normal.titleTextAttributes = normalAtt
            appearance.inlineLayoutAppearance.selected.titleTextAttributes = att
            bar.standardAppearance = appearance
        } else {
            bar.shadowImage = UIImage()
            bar.backgroundImage = img
            bar.backgroundColor = .clear
        }
        
        setValue(bar, forKey: "tabBar")
    }
    
    private func setupBinding() {
        
        let input = TabBarViewModel.Input()
        print(input)
        let output = viewModel.transform(input: input)
        
        output.tabBarItems.drive(onNext: {[weak self] items in
            guard let self = self else { return }
            self.itemDelegate?.showChildControllers(tabController: self, items: items)
        }).disposed(by: rx.disposeBag)
        
    }
    
//    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
//        guard let bar = tabBar as? WPTabBar else {
//            return
//        }
//        bar.selectItem(at: item.tag)
//    }
//
//    func selecteIndex(_ index: Int) {
//        selectedIndex = index
//        guard let bar = tabBar as? WPTabBar else {
//            return
//        }
//        bar.selectItem(at: index)
//    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {

        switch item.tag {
        case 0:AnalyticsName.clickTable.event(["type" : "discover"])
        case 1:AnalyticsName.clickTable.event(["type" : "oncam"])
        case 2:AnalyticsName.clickTable.event(["type" : "message"])
        case 3:AnalyticsName.clickTable.event(["type" : "me"])
        default:
            break
        }
        NotificationCenter.default.post(name: .TabItemClicked, object:item.tag)
    }
}

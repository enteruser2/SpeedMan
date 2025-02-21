//
//  ViewController.swift
//  swift
//
//  Created by 7x on 2023/12/7.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view = CocosBridge.shared().getCocosView()
        self.navigationController?.navigationBar.isHidden = true
    
    }
    


    override var prefersStatusBarHidden: Bool {
        return true
    }
}


//
//  LWHSwiftViewController.swift
//  LWHTestOne
//
//  Created by mac on 2019/9/11.
//  Copyright © 2019 BraveShine. All rights reserved.
//

import UIKit

class LWHSwiftViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.red
        
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.frame = CGRect.init(x: 0, y: 300, width: 100, height: 40)
        button.backgroundColor = UIColor.blue
        button.titleLabel?.text = "点我"
        button.addTarget(self, action: #selector(tapAction), for: UIControl.Event.touchUpInside)
        self.view.addSubview(button)
        
    }
    @objc func tapAction() {
        print("你好")
    }

}

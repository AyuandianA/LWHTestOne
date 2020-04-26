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
        button.frame = CGRect.init(x: 100, y: 300, width: 200, height: 200)
        button.backgroundColor = UIColor.blue
        button.titleLabel?.text = "点我"
        button.titleLabel?.textColor = UIColor.red
        button.addTarget(self, action: #selector(tapAction), for: UIControl.Event.touchUpInside)
        self.view.addSubview(button)
        
        let obveHeight = 20.0;
        let widthTabbar = UIScreen.main.bounds.size.width / 5.0;
        let bottomCenterBar:LWHTabbarBottomIView = LWHTabbarBottomIView.init(frame: CGRect.init(x: widthTabbar * 2, y: CGFloat(-obveHeight), width: widthTabbar, height: CGFloat(49) + CGFloat(obveHeight)), andimage: UIImage.init(), obveHeight: Int(obveHeight));
        button.addSubview(bottomCenterBar);
        bottomCenterBar.tapButton.addTarget(self, action: #selector(tapBottomCenter), for: UIControl.Event.touchUpInside);
            
        }
    @objc func tapBottomCenter(button:UIButton)
    {
        
    }
    @objc func tapAction() {
        print("你好")
    }
    
}

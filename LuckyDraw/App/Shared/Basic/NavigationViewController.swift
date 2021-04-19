//
//  NavigationViewController.swift
//  LuckyDraw
//

import UIKit

class NavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont.PingFangSC.regular(size: 24)
        ]
        
        appearance.backgroundColor = UIColor.Customize.viewBackground
        appearance.shadowImage = UIImage()
        appearance.shadowColor = UIColor.clear
        
        navigationBar.standardAppearance = appearance
        
        navigationBar.tintColor = .white
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
}

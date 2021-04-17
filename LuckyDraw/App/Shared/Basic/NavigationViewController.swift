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
            NSAttributedString.Key.foregroundColor: UIColor.Customize.textBlack,
            NSAttributedString.Key.font: UIFont.PingFangSC.regular(size: 24)
        ]
        navigationBar.standardAppearance = appearance
        
        navigationBar.tintColor = UIColor.Customize.textBlack
    }
}

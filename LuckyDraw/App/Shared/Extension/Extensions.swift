//
//  Extensions.swift
//  LuckyDraw
//

import UIKit


extension UIColor {
    struct Customize {
        static var roundButtonNormal: UIColor {
            return UIColor(named: "round_button_normal") ?? UIColor()
        }
        
        static var roundButtonSelected: UIColor {
            return UIColor(named: "round_button_selected") ?? UIColor()
        }
        
        static var roundButtonDisabled: UIColor {
            return UIColor(named: "round_button_disabled") ?? UIColor()
        }
        
        static var stopButtonSelected: UIColor {
            return UIColor(named: "stop_button_selected") ?? UIColor()
        }
        
        static var textOrange: UIColor {
            return UIColor(named: "text_orange") ?? UIColor()
        }
        
        static var textBlack: UIColor {
            return UIColor(named: "text_black") ?? UIColor()
        }
    }
}


extension UIFont {
    struct PingFangSC {
        static func regular(size: CGFloat) -> UIFont {
            return UIFont.pingFangSCWith(size: size, weight: .regular)
        }
        
        static func thin(size: CGFloat) -> UIFont {
            return UIFont.pingFangSCWith(size: size, weight: .thin)
        }
        
        static func light(size: CGFloat) -> UIFont {
            return UIFont.pingFangSCWith(size: size, weight: .light)
        }
        
        static func medium(size: CGFloat) -> UIFont {
            return UIFont.pingFangSCWith(size: size, weight: .medium)
        }
        
        static func bold(size: CGFloat) -> UIFont {
            return UIFont.pingFangSCWith(size: size, weight: .semibold)
        }
    }
    
    private static func pingFangSCWith(size: CGFloat, weight: UIFont.Weight = .regular) -> UIFont {
        let descriptor = UIFontDescriptor(fontAttributes: [
            UIFontDescriptor.AttributeName.family : "PingFang SC",
            UIFontDescriptor.AttributeName.traits: [
                UIFontDescriptor.TraitKey.weight: weight
            ]
        ])
        let font = UIFont(descriptor: descriptor, size: size)
        return font
    }
}

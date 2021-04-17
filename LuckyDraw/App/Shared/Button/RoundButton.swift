//
//  RoundButton.swift
//  LuckyDraw
//

import UIKit
class RoundButton: UIButton {
    func configBackgroundImage(normalColor: UIColor = UIColor.Customize.roundButtonNormal,
                               selectedColor: UIColor = UIColor.Customize.roundButtonSelected,
                               disableColor: UIColor = UIColor.Customize.roundButtonDisabled,
                               buttonHeight: CGFloat = 50,
                               cornerRadius: CGFloat = 6) {
        layer.cornerRadius = cornerRadius
        
        let bgLayer = CAShapeLayer()
        bgLayer.frame = CGRect(x: 0, y: 0, width: buttonHeight * 2, height: buttonHeight)
        bgLayer.cornerRadius = cornerRadius
        bgLayer.masksToBounds = true
        bgLayer.backgroundColor = normalColor.cgColor
        let insets = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
        let normalImage = UIImage.imageFromLayer(bgLayer)?.resizableImage(withCapInsets: insets, resizingMode: .stretch)
        bgLayer.backgroundColor = selectedColor.cgColor
        let selectedImage = UIImage.imageFromLayer(bgLayer)?.resizableImage(withCapInsets: insets, resizingMode: .stretch)
        bgLayer.backgroundColor = disableColor.cgColor
        let disabledImage = UIImage.imageFromLayer(bgLayer)?.resizableImage(withCapInsets: insets, resizingMode: .stretch)
        setBackgroundImage(normalImage, for: .normal)
        setBackgroundImage(selectedImage, for: .selected)
        setBackgroundImage(selectedImage, for: .highlighted)
        setBackgroundImage(disabledImage, for: .disabled)
    }
}

extension UIImage {
    static func imageFromColor(_ color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) -> UIImage? {
        defer {
            UIGraphicsEndImageContext()
        }
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(size)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        context.setFillColor(color.cgColor)
        context.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        return image
    }
    
    static func imageFromLayer(_ layer: CALayer) -> UIImage? {
        defer {
            UIGraphicsEndImageContext()
        }
        UIGraphicsBeginImageContextWithOptions(layer.bounds.size, false, 0)
        
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        layer.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        return image
    }
    
    static func roundedImage(_ image: UIImage?, imageSize: CGSize,
                             corners: UIRectCorner, radius: CGSize) -> UIImage? {
        guard let image = image else { return nil }
        let frame = CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height)
        UIGraphicsBeginImageContext(imageSize)
        let path = UIBezierPath(roundedRect: frame, byRoundingCorners: corners, cornerRadii: radius)
        path.addClip()
        image.draw(in: frame)
        let roundedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return roundedImage
    }
}

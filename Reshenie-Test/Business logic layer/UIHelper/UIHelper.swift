//
//  UIHelper.swift
//  Reshenie-Test
//
//  Created by Kovs on 02.06.2023.
//

import UIKit
import SafariServices

extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views {
            view.translatesAutoresizingMaskIntoConstraints = false
            addSubview(view)
        }
    }
    
    func addShadow(color: CGColor, opacity: Float, shadowOffset: CGSize, shadowRadius: CGFloat) {
        self.layer.shadowColor = color
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowRadius = shadowRadius
    }
    
}

extension UILabel {
    convenience init(textAlignment: NSTextAlignment, numberOfLines: Int, textColor: UIColor) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
        self.numberOfLines = numberOfLines
        self.textColor = textColor
    }
    
    static func returnAttributedStringForElementsInDetail(of text: String, for fullText: String) -> NSAttributedString {
        
        let attributedString = NSMutableAttributedString(string: fullText)
        let boldRange = (fullText as NSString).range(of: text)
        let boldFont = UIFont.boldSystemFont(ofSize: 16)
        attributedString.addAttribute(NSAttributedString.Key.font, value: boldFont, range: boldRange)
        
        return attributedString
    }
}

extension UIViewController {
    func presentSafariVC(with url: URL, for vc: UIViewController, using color: UIColor) {
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = color
        vc.present(safariVC, animated: true)
    }
}

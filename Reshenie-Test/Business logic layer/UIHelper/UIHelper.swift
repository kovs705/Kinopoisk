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

extension UIViewController {
    func presentSafariVC(with url: URL, for vc: UIViewController, using color: UIColor) {
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = color
        vc.present(safariVC, animated: true)
    }
}

//
//  NavBarWrapper.swift
//  Reshenie-Test
//
//  Created by Kovs on 03.06.2023.
//

import UIKit
import SwiftUI

struct NavBarWrapper: UIViewRepresentable {
    var presenter: MainPresenterProtocol!
    
    func makeUIView(context: Context) -> UIView {
        let navBar = UIHostingController(rootView: NavBar(presenter: presenter))
        return navBar.view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}

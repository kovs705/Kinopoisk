//
//  Builder.swift
//  Reshenie-Test
//
//  Created by Kovs on 31.05.2023.
//

import UIKit

protocol BuilderProtocol {
    func getMainModule() -> UIViewController
}

final class Builder: BuilderProtocol {
    func getMainModule() -> UIViewController {
        let view = MainVC()
        let presenter = MainPresenter(view: view)
        view.presenter = presenter
        return view
    }
}

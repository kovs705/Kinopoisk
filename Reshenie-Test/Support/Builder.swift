//
//  Builder.swift
//  Reshenie-Test
//
//  Created by Kovs on 31.05.2023.
//

import UIKit

protocol BuilderProtocol {
    func getMainModule() -> UIViewController
    func getSearchModule() -> UIViewController
    func getDetailModule(film: Film?) -> UIViewController
}

final class Builder: BuilderProtocol {
    func getMainModule() -> UIViewController {
        let view = MainVC()
        let networkService = DefaultNetworkService()
        let presenter = MainPresenter(view: view, networkService: networkService)
        view.presenter = presenter
        return view
    }
    
    func getSearchModule() -> UIViewController {
        let view = SearchVC()
        let networkService = DefaultNetworkService()
        let presenter = SearchPresenter(view: view, networkService: networkService)
        view.presenter = presenter
        return view
    }
    
    func getDetailModule(film: Film?) -> UIViewController {
        let view = DetailVC()
        let presenter = DetailPresenter(view: view, film: film)
        view.presenter = presenter
        return view

    }
}

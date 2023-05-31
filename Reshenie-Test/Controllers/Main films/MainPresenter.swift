//
//  MainPresenter.swift
//  Reshenie-Test
//
//  Created by Kovs on 31.05.2023.
//

import UIKit

protocol MainViewProtocol: AnyObject {
    
}

protocol MainPresenterProtocol: AnyObject {
    
    init(view: MainViewProtocol)
}

final class MainPresenter: MainPresenterProtocol {
    
    weak var view: MainViewProtocol?
    
    required init(view: MainViewProtocol) {
        self.view = view
    }
    
    
}

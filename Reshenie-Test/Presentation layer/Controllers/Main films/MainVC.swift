//
//  MainVC.swift
//  Reshenie-Test
//
//  Created by Kovs on 31.05.2023.
//

import UIKit

class MainVC: UIViewController {
    
    var presenter: MainPresenterProtocol!
    
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        view.backgroundColor = .blue
        presenter.fetchTopFilms()
    }
    
    
    // MARK: - Other funcs
    
    
}


// MARK: - Protocol
extension MainVC: MainViewProtocol {
    
    func success() {
        print(presenter.topFilms)
    }
    
    func failure(error: Error) {
        "Hello"
    }
    
    
    
    
}
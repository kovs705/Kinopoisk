//
//  SearchVC.swift
//  Reshenie-Test
//
//  Created by Kovs on 02.06.2023.
//

import UIKit

class SearchVC: UIViewController {
    
    var presenter: SearchPresenterProtocol!
    
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        presenter.searchRequest = "Ёлки"
    }
    
    
    // MARK: - Other funcs
    
    
}


// MARK: - Protocol
extension SearchVC: SearchViewProtocol {
    
    func success() {
        print(presenter.films)
    }
    
    func failure(error: Error) {
        fatalError("No request")
    }
    
    
    
    
}

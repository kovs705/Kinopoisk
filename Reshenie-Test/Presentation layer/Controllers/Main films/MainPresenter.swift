//
//  MainPresenter.swift
//  Reshenie-Test
//
//  Created by Kovs on 31.05.2023.
//

import UIKit

protocol MainViewProtocol: AnyObject {
    func success()
    func failure(error: Error)
}

protocol MainPresenterProtocol: AnyObject {
    
    var topFilms: [TopFilm] { get set }
    var isFetching: Bool { get set }
    var page: Int { get set }
    
    init(view: MainViewProtocol, networkService: NetworkService)
    
    func fetchTopFilms()
}

final class MainPresenter: MainPresenterProtocol {
    
    weak var view: MainViewProtocol?
    var networkService: NetworkService!
    
    var page = 1
    var isFetching = false
    var topFilms = [TopFilm]()
    
    
    required init(view: MainViewProtocol, networkService: NetworkService) {
        self.view = view
        self.networkService = networkService
    }
    
    func fetchTopFilms() {
        let request = TopFilmsRequest(page: page)
        page += 1
        networkService.request(request) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let films):
                guard let films else { return }
                self.topFilms.append(contentsOf: films)
                self.view?.success()
                self.isFetching = false
            case .failure(let error):
                print(error)
                self.view?.failure(error: error)
                self.isFetching = false
            }
        }
    }
    
}

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
    
    var films: [Film] { get set }
    var isFetching: Bool { get set }
    
    init(view: MainViewProtocol, networkService: NetworkService)
    
    var searchRequest: String? { get set }
    func fetchFilms()
    func showSearchResults()
    
}

final class MainPresenter: MainPresenterProtocol {
    
    weak var view: MainViewProtocol?
    var networkService: NetworkService!
    var page = 1
    var isFetching = false
    var films = [Film]()
    
    var searchRequest: String?
    
    required init(view: MainViewProtocol, networkService: NetworkService) {
        self.view = view
        self.networkService = networkService
    }
    
    func fetchFilms() {
        <#code#>
    }
    
    func showSearchResults() {
        let request = FilmsRequest(keyword: searchRequest!, page: page)
        page += 1
        networkService.request(request) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let films):
                guard let films else { return }
                self.films.append(contentsOf: films)
                self.view?.success()
                self.isFetching = false
            case .failure(let error):
                self.view?.failure(error: error)
                self.isFetching = false
            }
        }
    }
    
}

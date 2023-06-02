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
    func fetchFilms(resultAction: Web.searchBy)
    
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
    
    func fetchFilms(resultAction: Web.searchBy) {
        let request = FilmsRequest(keyword: searchRequest, page: page, resultAction: resultAction)
        page += 1
        networkService.request(request) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let films):
                guard let films else { return }
                print(films)
                // self.films.append(contentsOf: films)
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

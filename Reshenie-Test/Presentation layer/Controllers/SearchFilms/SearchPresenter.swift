//
//  SearchPresenter.swift
//  Reshenie-Test
//
//  Created by Kovs on 02.06.2023.
//

import Foundation

protocol SearchViewProtocol: AnyObject {
    func success()
    func failure(error: Error)
}

protocol SearchPresenterProtocol: AnyObject {
    
    init(view: SearchViewProtocol, networkService: NetworkService)
    
    var films: [Film] { get set }
    var isFetching: Bool { get set }
    var page: Int { get set }
    
    var searchRequest: String? { get set }
    func fetchFilms()
}

final class SearchPresenter: SearchPresenterProtocol {
    
    weak var view: SearchViewProtocol?
    var networkService: NetworkService!
    
    var searchRequest: String?
    
    var films = [Film]()
    var isFetching = false
    var page = 1
    
    required init(view: SearchViewProtocol, networkService: NetworkService) {
        self.view = view
    }
    
    
    func fetchFilms() {
        let request = FilmsRequest(keyword: searchRequest, page: page, resultAction: .searchByKeyword)
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
                print(error)
                self.view?.failure(error: error)
                self.isFetching = false
            }
        }
    }
    
}

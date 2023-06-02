//
//  FilmsRequest.swift
//  Reshenie-Test
//
//  Created by Kovs on 31.05.2023.
//

import Foundation

// https://kinopoiskapiunofficial.tech/api/v2.1

struct FilmsRequest: DataRequest {
    
    private let apiKey: String = Web.APIKey.get
    
    
    var keyword: String
    var page = 1
    var resultAction: Web.searchBy
    
    var url: String {
        let baseUrl = "https://kinopoiskapiunofficial.tech/api/v2.1"
        let path = Web.Endpoint.films.rawValue
        
        switch resultAction {
        case .searchByKeyword:
            let searchBy = Web.searchBy.searchByKeyword.rawValue
            return baseUrl + path + searchBy
        case .top:
            let searchBy = Web.searchBy.top.rawValue
            return baseUrl + path + searchBy
        }
        
    }
    
    var queryItems: [String : String] {
        switch resultAction {
        case .searchByKeyword:
            return [
                "keyword": keyword,
                "page": "\(page)"
            ]
        case .top:
            return [
                "type": Web.TopBy.topBest250.rawValue,
                "page": "\(page)"
            ]
        }
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var headers: [String: String] {
        [
            "accept": "application/json",
            "X-API-KEY": "a215f3a6-0ba7-4dd1-ad7d-d148800d90cf"
        ]
    }
    
    init(keyword: String?, page: Int, resultAction: Web.searchBy) {
        self.keyword = keyword ?? ""
        self.page = page
        self.resultAction = resultAction
    }
    
    func decode(_ data: Data) throws -> [Film]? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let response = try decoder.decode(FilmResponse.self, from: data)
        return response.films
    }
    
    
    
}


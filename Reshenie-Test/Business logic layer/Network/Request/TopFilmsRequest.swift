//
//  TopFilmsRequest.swift
//  Reshenie-Test
//
//  Created by Kovs on 02.06.2023.
//

import Foundation

// https://kinopoiskapiunofficial.tech/api/v2.2

struct TopFilmsRequest: DataRequest {
    
    private let apiKey: String = Web.APIKey.get

    var page = 1
    
    var url: String {
        let baseUrl = "https://kinopoiskapiunofficial.tech/api/v2.2"
        let path = Web.Endpoint.films.rawValue
        let searchBy = Web.searchBy.top.rawValue
        
        return baseUrl + path + searchBy
        
        
    }
    
    var queryItems: [String : String] {
        return [
            "type": Web.TopBy.topBest250.rawValue,
            "page": "\(page)"
        ]
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
    
    init(page: Int) {
        self.page = page
    }
    
    func decode(_ data: Data) throws -> [TopFilm]? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let response = try decoder.decode(TopFilmsResponse.self, from: data)
        return response.films
    }
    
    
    
}



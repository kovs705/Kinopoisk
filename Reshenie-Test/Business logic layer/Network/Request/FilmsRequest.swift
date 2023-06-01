//
//  FilmsRequest.swift
//  Reshenie-Test
//
//  Created by Kovs on 31.05.2023.
//

import Foundation

// https://kinopoiskapiunofficial.tech/api/v2.2

struct FilmsRequest: DataRequest {
    
    private let apiKey: String = Web.APIKey.get
        
    var keyword: String!
    var page = 1
    
    var url: String {
        let baseUrl = "https://kinopoiskapiunofficial.tech/api/v2.2"
        let path = Web.Endpoint.films.rawValue
        let searchBy = Web.searchBy.searchByKeyword.rawValue
        return baseUrl + path + searchBy
    }

    var queryItems: [String : String] {
        [
            "apiKey": apiKey,
            "keyword": keyword,
            "page": "\(page)"
        ]
    }
    
    var method: HTTPMethod {
        .get
    }
    
    init(keyword: String, page: Int) {
        self.keyword = keyword
        self.page = page
    }
    
    func decode(_ data: Data) throws -> [Film]? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let response = try decoder.decode(FilmResponse.self, from: data)
        return response.films
    }
    
}


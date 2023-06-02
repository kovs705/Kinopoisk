//
//  Constants.swift
//  Reshenie-Test
//
//  Created by Kovs on 31.05.2023.
//

import Foundation


enum Web {
    enum APIKey {
        static let get = "a215f3a6-0ba7-4dd1-ad7d-d148800d90cf"
    }
    
    enum Endpoint: String {
        case films = "/films/"
        case staff = "/staff/"
    }
    
    enum searchBy: String {
        case searchByKeyword = "search-by-keyword?"
        case top = "top?"
    }
    
    enum TopBy: String {
        case topBest250 = "TOP_250_BEST_FILMS"
        case topPopular100 = "TOP_100_POPULAR_FILMS"
        case topAwait = "TOP_AWAIT_FILMS"
    }
}

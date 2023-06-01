//
//  ErrorResponse.swift
//  Reshenie-Test
//
//  Created by Kovs on 31.05.2023.
//

enum ErrorResponse: String {
    case apiError
    case invalidEndpoint
    case invalidResponse
    case noData
    case serializationError
    
    public var description: String {
        switch self {
        case .apiError: return "Smth wrong with api"
        case .invalidEndpoint: return "Ooops, smth wrong with the endpoint"
        case .invalidResponse: return "Ooops, smth wrong with the response"
        case .noData: return "Ooops, smth wrong with the data"
        case .serializationError: return "Ooops, smth wrong with the serialization process"
        }
    }
}

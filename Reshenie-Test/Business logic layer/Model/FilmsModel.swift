//
//  FilmsModel.swift
//  Reshenie-Test
//
//  Created by Kovs on 01.06.2023.
//

import Foundation

protocol FilmProtocol {
    var filmId: Int { get }
    var nameRu: String? { get }
    var nameEn: String? { get }
    var year: String? { get }
    var countries: [Country] { get }
    var genres: [Genre] { get }
    var rating: String { get }
    var ratingVoteCount: Int { get }
}

struct FilmResponse: Decodable {
    let keyword: String
    let pagesCount: Int
    let films: [Film]
    let searchFilmsCountResult: Int
}

struct Film: Codable, Hashable, FilmProtocol {
    let filmId: Int
    let nameRu: String?
    let nameEn: String?
    let type: String
    let year: String?
    let description: String?
    let filmLength: String?
    let countries: [Country]
    let genres: [Genre]
    let rating: String
    let ratingVoteCount: Int
    let posterUrl: String?
    let posterUrlPreview: String?
    
}

struct Country: Codable, Hashable {
    let country: String
}

struct Genre: Codable, Hashable {
    let genre: String
}


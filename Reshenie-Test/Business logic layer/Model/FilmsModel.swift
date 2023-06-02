//
//  FilmsModel.swift
//  Reshenie-Test
//
//  Created by Kovs on 01.06.2023.
//

import Foundation

struct FilmResponse: Decodable {
    let keyword: String
    let pagesCount: Int
    let films: [Film]
    let searchFilmsCountResult: Int
}

struct Film: Codable, Hashable {
    let filmId: Int
    let nameRu: String?
    let nameEn: String?
    let type: String
    let year: String
    let description: String?
    let filmLength: String?
    let countries: [Country]
    let genres: [Genre]
    let rating: String
    let ratingVoteCount: Int
    let posterUrl: URL?
    let posterUrlPreview: URL?
}

struct Country: Codable, Hashable {
    let country: String
}

struct Genre: Codable, Hashable {
    let genre: String
}

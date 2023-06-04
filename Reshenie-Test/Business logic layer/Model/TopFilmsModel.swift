//
//  TopFilmsModel.swift
//  Reshenie-Test
//
//  Created by Kovs on 01.06.2023.
//

import Foundation

struct TopFilmsResponse: Decodable {
    let pagesCount: Int
    let films: [TopFilm]
}

struct TopFilm: Codable, Hashable, FilmProtocol {
    let filmId: Int
    let nameRu: String?
    let nameEn: String?
    let year: String?
    let filmLength: String
    let countries: [Country]
    let genres: [Genre]
    let rating: String
    let ratingVoteCount: Int
    let posterUrl: URL?
    let posterUrlPreview: URL?
    let ratingChange: String?
    
}

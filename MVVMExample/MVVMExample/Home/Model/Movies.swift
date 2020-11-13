//
//  Movies.swift
//  MVVMExample
//
//  Created by macbook on 11/13/20.
//

import Foundation

struct Movies {
    let listOfMovies = [Movie]
    
    enum CodingKeys: String, CodingKeys {
        case listOfMovies = "results"
    }
}

struct Movie: Codable {
    let id: Int
    let title: String
    let popularity: Double
    let voteCount: Int
    let originalTitle: String
    let voteAverage: Double
    let overview: String
    let releaseDate: String
    let imageUrl: String
    
    enum CodingKeys: String, CodingKeys {
        case id
        case title
        case popularity
        case voteCount = "vote_count"
        case originalTitle = "original_title"
        case voteAverage
        case overview
        case releaseDate = "release_date"
        case imageUrl = "poster_path"
    }
}

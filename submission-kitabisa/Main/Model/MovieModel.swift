//
//  MovieModel.swift
//  submission-kitabisa
//
//  Created by Muhammad Hilmy Fauzi on 20/12/20.
//

import Foundation

class ResponseMovie: Codable {
    let results: [MovieModel]
    
    enum CodingKeys: String, CodingKey {
        case results = "results"
    }
}

class MovieModel: Codable {
    let backdrop_path: String
    let id: Int
    let overview: String
    let release_date: String
    let title: String
    let poster_path: String
    
    enum CodingKeys: String, CodingKey {
        case backdrop_path = "backdrop_path"
        case id = "id"
        case overview = "overview"
        case release_date = "release_date"
        case title = "title"
        case poster_path = "poster_path"
    }
    
    init(backdropPath: String, id: Int, overview: String, releaseDate: String, title: String, posterPath: String) {
        self.backdrop_path = backdropPath
        self.id = id
        self.overview = overview
        self.release_date = releaseDate
        self.title = title
        self.poster_path = posterPath
    }
}

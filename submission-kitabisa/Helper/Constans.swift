//
//  Constans.swift
//  submission-kitabisa
//
//  Created by Muhammad Hilmy Fauzi on 20/12/20.
//

import Foundation

struct K {
    struct URL {
        static let BASE_URL_API = "https://api.themoviedb.org/3/movie/"
        static let BASE_URL_IMAGE = "https://image.tmdb.org/t/p/original"
        
        static let API_KEY = "3de24acd486b976ff4b5df869947e036"
        static let END_URL = "?api_key=" + API_KEY
    }
    
    struct Notif {
        static let NOTIF_CATEGORY_SELECTED = Notification.Name("categorySelected")
    }
    
    struct Core {
        static let entityMovie = "MovieEntity"
        static let id = "id"
        static let overview = "overview"
        static let releaseDate = "release_date"
        static let title = "title"
        static let backdropPath = "backdrop_path"
        static let posterPath = "poster_path"
    }
}

enum MovieType: String {
    case popular = "popular"
    case upcoming = "upcoming"
    case topRated = "top_rated"
    case nowPlaying = "now_playing"
}

func beautifyString(from type: MovieType) -> String {
    let str = type.rawValue
    
    let processedStr = str.components(separatedBy: "_")
        .joined(separator: " ")
        .capitalized
    
    return processedStr
}

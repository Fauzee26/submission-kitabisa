//
//  DetailModel.swift
//  submission-kitabisa
//
//  Created by Muhammad Hilmy Fauzi on 21/12/20.
//

import Foundation

class ResponseDetail: Codable {
    let backdrop_path: String
    let id: Int
    let overview: String
    let title: String
    let vote_average: Double
    let release_date: String
    let poster_path: String
}

//
//  ReviewModel.swift
//  submission-kitabisa
//
//  Created by Muhammad Hilmy Fauzi on 21/12/20.
//

import Foundation

class ResponseReview: Codable {
    let results: [ReviewModel]
}

class ReviewModel: Codable {
    let author: String
    let content: String
    let created_at: String
    let id: String
}

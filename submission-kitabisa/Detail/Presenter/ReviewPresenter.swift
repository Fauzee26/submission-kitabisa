//
//  ReviewPresenter.swift
//  submission-kitabisa
//
//  Created by Muhammad Hilmy Fauzi on 21/12/20.
//

import Foundation

protocol ReviewDelegate {
    func loadReviewsSuccess(reviews: [ReviewModel])
    func loadReviewsFail(error: String)
}

class ReviewPresenter {
    private var delegate: ReviewDelegate
    
    init(delegate: ReviewDelegate) {
        self.delegate = delegate
    }
    
    func fetchReviewsMovie(id: Int) {
        let strUrl = K.URL.BASE_URL_API + "\(id)/reviews" + K.URL.END_URL
        let url = URL(string: strUrl)!
        URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            if let err = error {
                self.delegate.loadReviewsFail(error: err.localizedDescription)
                return
            }
            
            do {
                let json = try JSONDecoder().decode(ResponseReview.self, from: data!)
                
                print("review count: ", json.results.count)
                
                self.delegate.loadReviewsSuccess(reviews: json.results)
            } catch {
                self.delegate.loadReviewsFail(error: "Error suring JSON Serialization: \(error.localizedDescription)")
            }
        }).resume()
    }
}

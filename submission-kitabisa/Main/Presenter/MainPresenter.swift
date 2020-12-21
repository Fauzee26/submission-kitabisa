//
//  MainPresenter.swift
//  submission-kitabisa
//
//  Created by Muhammad Hilmy Fauzi on 20/12/20.
//

import Foundation

protocol MainDelegate {
    func loadMoviesSuccess(movies: [MovieModel])
    func loadMoviesFail(error: String)
}

class MainPresenter {
    private var delegate: MainDelegate
    
    init(delegate: MainDelegate) {
        self.delegate = delegate
    }
    
    func fetchListMovies(type: MovieType) {
        let strUrl = K.URL.BASE_URL_API + type.rawValue + K.URL.END_URL

        let url = URL(string: strUrl)!
        URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            // Check if an error occured
            if let err = error {
                // here you can manage the error
                self.delegate.loadMoviesFail(error: err.localizedDescription)
                return
            }
            
            do {
                let json = try JSONDecoder().decode(ResponseMovie.self, from: data!)
                self.delegate.loadMoviesSuccess(movies: json.results)
            } catch {
                self.delegate.loadMoviesFail(error: "Error during JSON serialization: \(error.localizedDescription)")
            }
        }).resume()
    }
}

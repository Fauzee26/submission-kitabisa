//
//  FavoritePresenter.swift
//  submission-kitabisa
//
//  Created by Muhammad Hilmy Fauzi on 21/12/20.
//

import UIKit
import CoreData

protocol FavoriteDelegate {
    func loadFavoritesSuccess(movies: [MovieModel])
    func loadMoviesFail(error: String)
}

class FavoritePresenter {
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    private var delegate: FavoriteDelegate
    
    init(delegate: FavoriteDelegate) {
        self.delegate = delegate
    }
    
    func fetchFavoriteMovies() {
        var moviesList = [MovieModel]()
        
        if let appDelegate = appDelegate {
            let managedContext = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: K.Core.entityMovie)
            
            do {
                let results = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
                
                results?.forEach { movie in
                    moviesList.append(
                        MovieModel(
                            backdropPath: movie.value(forKey: K.Core.backdropPath) as! String,
                            id: movie.value(forKey: K.Core.id) as! Int,
                            overview: movie.value(forKey: K.Core.overview) as! String,
                            releaseDate: movie.value(forKey: K.Core.releaseDate) as! String,
                            title: movie.value(forKey: K.Core.title) as! String,
                            posterPath: movie.value(forKey: K.Core.posterPath) as! String
                        )
                    )
                }
                
                delegate.loadFavoritesSuccess(movies: moviesList)
            } catch let err {
                delegate.loadMoviesFail(error: "Error Fetch Favorite Movies: \(err.localizedDescription)")
            }
        }
    }
}

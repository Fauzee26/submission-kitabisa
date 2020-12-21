//
//  FavoriteVC.swift
//  submission-kitabisa
//
//  Created by Muhammad Hilmy Fauzi on 21/12/20.
//

import UIKit

class FavoriteVC: UITableViewController {

    var moviesList = [MovieModel]()
    
    var presenter: FavoritePresenter?
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Favorites"
        tableView.register(UINib(nibName: "MainViewCell", bundle: self.nibBundle), forCellReuseIdentifier: "mainViewCell")
        
        presenter = FavoritePresenter(delegate: self)
        presenter?.fetchFavoriteMovies()
    }

    override func viewWillAppear(_ animated: Bool) {
        presenter?.fetchFavoriteMovies()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesList.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        var numOfSection: Int = 0
        if moviesList.isEmpty {
            let noDataLabel: UILabel  = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLabel.text          = "No favorites movies!"
            noDataLabel.textColor     = UIColor.label
            noDataLabel.textAlignment = .center
            tableView.backgroundView  = noDataLabel
            tableView.separatorStyle  = .none
        } else {
            numOfSection = 1
            tableView.backgroundView = nil
            tableView.separatorStyle = .singleLine
        }
        
        return numOfSection
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "mainViewCell", for: indexPath) as? MainViewCell else { return UITableViewCell() }

        let movie = moviesList[indexPath.row]
        cell.configureCell(model: movie)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = moviesList[indexPath.row]

        let storyboard = UIStoryboard(name: "Detail", bundle: nil)
        let detailVC = storyboard.instantiateViewController(identifier: "DetailVC") as! DetailVC
        detailVC.movieId = movie.id
        
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension FavoriteVC: FavoriteDelegate {
    func loadFavoritesSuccess(movies: [MovieModel]) {
        moviesList.removeAll()
        moviesList = movies
        
        tableView.reloadData()
    }
    
    func loadMoviesFail(error: String) {
        print(error)
    }
}

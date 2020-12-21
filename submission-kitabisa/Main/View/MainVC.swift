//
//  MainVC.swift
//  submission-kitabisa
//
//  Created by Muhammad Hilmy Fauzi on 17/12/20.
//

import UIKit

class MainVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnCategory: UIButton!
    
    let alert = UIAlertController(title: nil, message: "Loading Movies...", preferredStyle: .alert)
    
    var moviesList = [MovieModel]()
    var presenter: MainPresenter?
    
    var movieType = MovieType.popular
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MainViewCell", bundle: self.nibBundle), forCellReuseIdentifier: "mainViewCell")
        
        presenter = MainPresenter(delegate: self)
        
        setupUI()
        
        loadingProgress()
        presenter?.fetchListMovies(type: movieType)
                
        NotificationCenter.default.addObserver(self, selector: #selector(categorySelected(_:)), name: K.Notif.NOTIF_CATEGORY_SELECTED, object: nil)
    }
    
    private func setupUI() {
        btnCategory.layer.cornerRadius = 12
        btnCategory.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    private func loadingProgress() {
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating();
        alert.view.addSubview(loadingIndicator)
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func categorySelected(_ notif: Notification) {
        loadingProgress()
        
        let category = notif.object as! MovieType
        movieType = category
        
        presenter?.fetchListMovies(type: movieType)
    }
    
    @IBAction func btnGoToFavorite(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = storyboard.instantiateViewController(identifier: "FavoriteVC") as! FavoriteVC
        
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    @IBAction func btnCategory(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let categoryVC = storyboard.instantiateViewController(identifier: "CategoryVC") as! CategoryVC
        self.present(categoryVC, animated: true, completion: nil)
    }
}

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "mainViewCell") as? MainViewCell else { return UITableViewCell() }
        
        let movie = moviesList[indexPath.row]
        cell.configureCell(model: movie)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = moviesList[indexPath.row]

        let storyboard = UIStoryboard(name: "Detail", bundle: nil)
        let detailVC = storyboard.instantiateViewController(identifier: "DetailVC") as! DetailVC
        detailVC.movieId = movie.id
        
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension MainVC: MainDelegate {
    func loadMoviesSuccess(movies: [MovieModel]) {
        DispatchQueue.main.async {
            self.alert.dismiss(animated: true, completion: nil)
            self.moviesList.removeAll()
            self.moviesList = movies
            self.tableView.reloadData()
            
            self.title = beautifyString(from: self.movieType)

        }
    }
    
    func loadMoviesFail(error: String) {
        alert.dismiss(animated: true, completion: nil)
        print(error)
    }
}

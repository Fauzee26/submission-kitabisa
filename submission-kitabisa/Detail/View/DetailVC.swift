//
//  DetailVC.swift
//  submission-kitabisa
//
//  Created by Muhammad Hilmy Fauzi on 18/12/20.
//

import UIKit

class DetailVC: UIViewController {

    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblOverview: UILabel!
    @IBOutlet weak var btnFavorite: UIButton!
    @IBOutlet weak var btnSeeReviews: UIButton!
    
    var movieId: Int?
    
    let imgHeart = UIImage(systemName: "heart")
    let imgHeartFill = UIImage(systemName: "heart.fill")
    
    var presenter: DetailPresenter?
    
    var movieModel: MovieModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        presenter = DetailPresenter(delegate: self)
        presenter?.fetchDetailMovie(id: movieId!)
    }
    
    func setupUI() {
        btnFavorite.imageView?.contentMode = .scaleAspectFit
        btnSeeReviews.layer.cornerRadius = 8
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if presenter != nil {
            presenter?.fetchDetailMovie(id: movieId!)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        imgPoster.image = nil
        imgPoster.cancelImageLoad()
    }
    
    @IBAction func btnFavoritePressed(_ sender: Any) {
        presenter?.saveOrRemove(model: movieModel!)
        presenter?.isFavorite(movieModel!)
    }
    
    @IBAction func btnSeeReviewsPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Detail", bundle: nil)
        let reviewsVC = storyboard.instantiateViewController(identifier: "ReviewsVC") as! ReviewsVC
        reviewsVC.movieId = movieId
        
        self.navigationController?.pushViewController(reviewsVC, animated: true)
    }
}

extension DetailVC: DetailDelegate {
    func isModelSaved(status: Bool) {
        DispatchQueue.main.async {
            self.btnFavorite.setImage(status ? self.imgHeartFill : self.imgHeart, for: .normal)
        }
    }
    
    func isSaveModelSuccess(status: Bool) {
        print("saved status: ", status)
    }
    
    func isRemoveModelSuccess(status: Bool) {
        print("remove status: ", status)
    }
    
    func loadDetailSuccess(model: ResponseDetail) {
        DispatchQueue.main.async {
            self.loadDataToUI(data: model)
        }
        
        movieModel = MovieModel(backdropPath: model.backdrop_path, id: model.id, overview: model.overview, releaseDate: model.release_date, title: model.title, posterPath: model.poster_path)
        presenter?.isFavorite(movieModel!)
    }
    
    func loadDetailFail(error: String) {
        print(error)
    }
    
    func loadDataToUI(data: ResponseDetail) {
        imgPoster.loadImage(at: URL(string: K.URL.BASE_URL_IMAGE + data.backdrop_path)!)
        lblTitle.text = data.title
        lblDate.text = data.release_date
        lblOverview.text = data.overview
    }
}

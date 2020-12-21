//
//  ReviewsVC.swift
//  submission-kitabisa
//
//  Created by Muhammad Hilmy Fauzi on 21/12/20.
//

import UIKit

class ReviewsVC: UITableViewController {
    
    var movieId: Int?
    var reviewList = [ReviewModel]()
    
    var presenter: ReviewPresenter?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Reviews"
        tableView.register(UINib(nibName: "ReviewsViewCell", bundle: self.nibBundle), forCellReuseIdentifier: "reviewsViewCell")
        
        presenter = ReviewPresenter(delegate: self)
        presenter?.fetchReviewsMovie(id: movieId!)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewList.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        var numOfSection: Int = 0
        if reviewList.isEmpty {
            let noDataLabel: UILabel  = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLabel.text          = "No review available!"
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "reviewsViewCell") as? ReviewsViewCell else { return UITableViewCell() }
        
        let review = reviewList[indexPath.row]
        cell.configureCell(model: review)
        
        return cell
    }
}

extension ReviewsVC: ReviewDelegate {
    func loadReviewsSuccess(reviews: [ReviewModel]) {
        DispatchQueue.main.async {
            self.reviewList.removeAll()
            self.reviewList = reviews
            self.tableView.reloadData()
        }
        
    }
    
    func loadReviewsFail(error: String) {
        print(error)
    }
    
    
}

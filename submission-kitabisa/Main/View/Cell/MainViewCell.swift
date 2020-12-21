//
//  MainViewCell.swift
//  submission-kitabisa
//
//  Created by Muhammad Hilmy Fauzi on 18/12/20.
//

import UIKit

class MainViewCell: UITableViewCell {

    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblReleaseDate: UILabel!
    @IBOutlet weak var lblOverview: UILabel!
    
    func configureCell(model: MovieModel) {
        lblTitle.text = model.title
        lblReleaseDate.text = model.release_date
        lblOverview.text = model.overview
        imgPoster.loadImage(at: URL(string: K.URL.BASE_URL_IMAGE + model.poster_path)!)
    }
    
    override func prepareForReuse() {
        imgPoster.image = nil
        imgPoster.cancelImageLoad()
    }
}

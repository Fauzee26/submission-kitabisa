//
//  ReviewsViewCell.swift
//  submission-kitabisa
//
//  Created by Muhammad Hilmy Fauzi on 21/12/20.
//

import UIKit

class ReviewsViewCell: UITableViewCell {

    @IBOutlet weak var lblAuthor: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblContent: UILabel!
    
    func configureCell(model: ReviewModel) {
        lblAuthor.text = model.author
        lblDate.text = formattedDate(strDate: model.created_at)
        lblContent.text = model.content
    }
    
    private func formattedDate(strDate: String) -> String {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        isoFormatter.formatOptions = [
            .withFullDate,
            .withFullTime,
            .withDashSeparatorInDate,
            .withFractionalSeconds]
        let formattedDate = isoFormatter.date(from: strDate)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, YYYY"
        
        return dateFormatter.string(from: formattedDate!)
    }
}

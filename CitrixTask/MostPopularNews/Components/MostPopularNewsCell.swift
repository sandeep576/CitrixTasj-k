//
//  MostPopularNewsCell.swift
//  CitrixTask
//
//  Created by Sai Sandeep on 02/07/22.
//

import Foundation
import UIKit

class MostPopularNewsCell: UITableViewCell {

    static let cellIdentifier = "MostPopularNewsCellIdentifier"

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var authorLbl: UILabel!
    @IBOutlet weak var abstractLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var containerView: UIView!

    func setupData(item: Results) {
        titleLbl.text = item.title
        abstractLbl.text = item.abstract
        authorLbl.text = item.byline
        dateLabel.text = item.publishedDate
        imgView.isHidden = item.media.count == 0
        if let urlString = item.media.first?.mediaMetadata.first?.url {
            imgView?.loadThumbnail(urlSting: urlString)
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.layer.cornerRadius = 5
    }
}

//
//  MovieCell.swift
//  Flix-Movie
//
//  Created by XiaoQian Huang on 9/13/18.
//  Copyright © 2018 XiaoQian Huang. All rights reserved.
//

import UIKit
import Foundation
import AlamofireImage

class MovieCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var overviewLabel: UILabel!
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    var movie: Movie! {
        didSet{
            let title = movie.title
            let overview = movie.overview
            let imagePath = movie.posterUrl
            let baseURLString = "https://image.tmdb.org/t/p/w500"
            let imageUrl = URL(string: baseURLString + imagePath)!
            titleLabel.text = title
            overviewLabel.text = overview
            posterImageView.af_setImage(withURL: imageUrl)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

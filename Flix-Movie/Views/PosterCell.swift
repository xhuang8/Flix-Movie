//
//  PosterCell.swift
//  Flix-Movie
//
//  Created by XiaoQian Huang on 9/14/18.
//  Copyright © 2018 XiaoQian Huang. All rights reserved.
//

import UIKit

class PosterCell: UICollectionViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    var movie: Movie! {
        didSet{
            let title = movie.title
            let overview = movie.overview
            let imagePath = movie.posterUrl
            let baseURLString = "https://image.tmdb.org/t/p/w500"
            let imageUrl = URL(string: baseURLString + imagePath)!
           // titleLabel.text = title
            //overviewLabel.text = overview
            posterImageView.af_setImage(withURL: imageUrl)
        }
    }
}

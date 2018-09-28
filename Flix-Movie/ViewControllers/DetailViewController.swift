//
//  DetailViewController.swift
//  Flix-Movie
//
//  Created by XiaoQian Huang on 9/14/18.
//  Copyright © 2018 XiaoQian Huang. All rights reserved.
//

import UIKit

/*enum MovieKeys {
    static let title = "title"
    static let backdropPath = "backdrop_path"
    static let posterPath = "poster_path"
}*/



class DetailViewController: UIViewController {

    @IBOutlet weak var backDropImageView: UIImageView!
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    @IBOutlet weak var overviewLabel: UILabel!
    
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let movie = movie {
            titleLabel.text = movie.title
            releaseDateLabel.text = movie.releaseDate
            overviewLabel.text = movie.overview
            
            let backdropPathString = "\(String(describing: movie.backdropBathUrl))"
            
            let posterPathString = "\(String(describing: movie.posterUrl))"
            
            let baseURLString = "https://image.tmdb.org/t/p/w500"
            
            let backdropURL = URL(string: baseURLString + backdropPathString)!
            backDropImageView.af_setImage(withURL: backdropURL)
            
            let posterPathURL = URL(string: baseURLString + posterPathString)!
            posterImageView.af_setImage(withURL: posterPathURL)
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

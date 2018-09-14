//
//  SuperheroViewController.swift
//  Flix-Movie
//
//  Created by XiaoQian Huang on 9/14/18.
//  Copyright © 2018 XiaoQian Huang. All rights reserved.
//

import UIKit

class SuperheroViewController: UIViewController, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    var movies: [[String: Any]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //fetchMovies()
        collectionView.dataSource = self
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = layout.minimumInteritemSpacing
        
        let cellsPerline: CGFloat = 2
        let interItemSpacingTotal = layout.minimumInteritemSpacing * (cellsPerline - 1)
        
        let width = collectionView.frame.size.width / cellsPerline - interItemSpacingTotal / cellsPerline
        layout.itemSize = CGSize(width: width, height: width * 3 / 2)
        
        
        
        fetchMovies()
        // Do any additional setup after loading the view.
        
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PosterCell", for: indexPath)as! PosterCell
        
        let movie = movies[indexPath.item]
        if let posterPathString = movie["poster_path"]as? String{
            let baseURLString = "https://image.tmdb.org/t/p/w500"
            let posterURL = URL(string: baseURLString + posterPathString)!
            cell.posterImageView.af_setImage(withURL: posterURL)
            
            
        }
        return cell
    }
    
    
    func fetchMovies(){
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            //this will run when the network request returns
            
            
            if let error = error
            {
                print(error.localizedDescription)
                //self.myAlert(title: "Cannot Get Movies", message: "The Internet connection appears to be offline.")
            }
            else if let data = data
            {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                print(dataDictionary)
                
                let movies  = dataDictionary["results"] as! [[String: Any]]
                for movie in movies{
                    let title = movie["title"] as! String
                    print(title)
                    self.movies = movies
                    self.collectionView.reloadData()
                    //self.refreshControl.endRefreshing()
                    // self.activityIndiator.stopAnimating()
                }
            }
        }
        task.resume()
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
}

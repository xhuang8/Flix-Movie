//
//  NowPlayingViewController.swift
//  Flix-Movie
//
//  Created by XiaoQian Huang on 9/13/18.
//  Copyright © 2018 XiaoQian Huang. All rights reserved.
//

import UIKit
import AlamofireImage

class NowPlayingViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndiator: UIActivityIndicatorView!
    
   
    
    //var movies: [[String: Any]] = []
    var movies: [Movie] = []
    
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(NowPlayingViewController.didPullToRefresh(_:)), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
        
        self.activityIndiator.startAnimating()
       // fetchMovies()
        
        
        //tableView.dataSource = self
        MovieApiManager().nowPlayingMovies { (movies: [Movie]?, error: Error?) in
            if let movies = movies {
                self.movies = movies
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
                self.activityIndiator.stopAnimating()
            }else if let error = error{
                print(error.localizedDescription)
                self.myAlert(title: "Cannot Get Movies", message: "The Internet connection appears to be offline.")
            }
        }
        
    }
    
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl)
    {
        //fetchMovies()
        MovieApiManager().nowPlayingMovies { (movies: [Movie]?, error: Error?) in
            if let movies = movies {
                self.movies = movies
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
                self.activityIndiator.stopAnimating()
            }else if let error = error{
                print(error.localizedDescription)
                self.myAlert(title: "Cannot Get Movies", message: "The Internet connection appears to be offline.")
            }
        }
    }
    
    
    @IBAction func popularMovies(_ sender: Any) {
        
        MovieApiManager().getPopularMovies{ (movies: [Movie]?, error: Error?) in
            if let movies = movies {
                self.movies = movies
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
                self.activityIndiator.stopAnimating()
            }else if let error = error{
                print(error.localizedDescription)
                self.myAlert(title: "Cannot Get Movies", message: "The Internet connection appears to be offline.")
            }
        }
    }
    //override func viewDidAppear(_ animated: Bool) {
    //myAlert(title: "Cannot Get Movies", message: "The Internet connection appears to be offline.")
    //}
    //create alertfunction, sees an alert when there's a networking error.
    
    func myAlert(title: String, message: String)
    {
        let alertController = UIAlertController(title: "Cannot Get Movies", message: "The Internet connection appears to be offline.", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "TRY AGAIN", style: .default, handler: { (action) in
            // handle response here.
            alertController.dismiss(animated: true, completion: nil)
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    
   /* func fetchMovies()
    {
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            //this will run when the network request returns
            
            
            if let error = error
            {
                print(error.localizedDescription)
                self.myAlert(title: "Cannot Get Movies", message: "The Internet connection appears to be offline.")
            }
            else if let data = data
            {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                print(dataDictionary)
                
                let movieDictionaries  = dataDictionary["results"] as! [[String: Any]]
                self.movies = []
                for dictionary in movieDictionaries{
               // for movie in movies{
                   // let title = movie["title"] as! String
                  //  print(title)
                   // self.movies = movies
                    let movie = Movie(dictionary: dictionary)
                    self.movies.append(movie)
                    self.tableView.reloadData()
                    self.refreshControl.endRefreshing()
                    self.activityIndiator.stopAnimating()
                }
            }
        }
        task.resume()
    }*/
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        /*let movie = movies[indexPath.row]
        let title = movie ["title"] as! String
        let overview = movie["overview"] as! String
        cell.titleLabel.text = title
        cell.overviewLabel.text = overview
        
        let posterPathString = movie["poster_path"] as! String
        let baseURLString = "https://image.tmdb.org/t/p/w500"
        
        let posterURL = URL(string: baseURLString + posterPathString)!
        cell.posterImageView.af_setImage(withURL: posterURL)*/
        
        cell.movie = movies[indexPath.row]
        return cell
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let cell = sender as! UITableViewCell
        
        if let indexPath = tableView.indexPath(for: cell){
            
            let movie = movies[indexPath.row]
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.movie = movie
            
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
}

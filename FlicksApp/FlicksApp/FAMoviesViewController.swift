//
//  FAMoviesViewController.swift
//  FlicksApp
//
//  Created by Gauri Tikekar on 3/30/17.
//  Copyright © 2017 Gauri Tikekar. All rights reserved.
//

import UIKit
import SVProgressHUD

class FAMoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var movieFilterType: String? = nil
    var movies: [NSDictionary] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let refreshControl = UIRefreshControl()
        
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        // add refresh control to table view
        tableView.insertSubview(refreshControl, at: 0)
        let urlString: String! = "https://api.themoviedb.org/3/movie/" + movieFilterType! + "?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed";
        loadMovies(urlString: urlString)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true;
    }
    
    func loadMovies(urlString: String) {
        
        //let urlString: String! = "https://api.themoviedb.org/3/movie/" + movieFilterType! + "?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed";
        let url = URL(string:urlString)
        let request = URLRequest(url: url!)
        let session = URLSession(
            configuration: URLSessionConfiguration.default,
            delegate:nil,
            delegateQueue:OperationQueue.main
        )
        SVProgressHUD.show()
        let task : URLSessionDataTask = session.dataTask(
            with: request as URLRequest,
            completionHandler: { (data, response, error) in
                SVProgressHUD.dismiss()
                if let data = data {
                    if let responseDictionary = try! JSONSerialization.jsonObject(
                        with: data, options:[]) as? NSDictionary {
                        self.movies = responseDictionary["results"] as! [NSDictionary]
                        self.tableView.reloadData()
                    }
                }
        });
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:
            "MovieCell") as! FAMovieTableViewCell
        let movie = movies[indexPath.row]
        cell.setUI(aMovie: movie)
        return cell
    }
    
    func refreshControlAction(_ refreshControl: UIRefreshControl) {
        let urlString: String! = "https://api.themoviedb.org/3/movie/" + movieFilterType! + "?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed";
        loadMovies(urlString: urlString)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        var urlString: String! = "https://api.themoviedb.org/3/search/movie?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&query=" + searchBar.text!
        if(searchBar.text == nil) {
            urlString = "https://api.themoviedb.org/3/movie/" + movieFilterType! + "?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"
        }
        loadMovies(urlString: urlString)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        let urlString = "https://api.themoviedb.org/3/movie/" + movieFilterType! + "?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"
        loadMovies(urlString: urlString)
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(searchText.isEmpty) {
            let urlString = "https://api.themoviedb.org/3/movie/" + movieFilterType! + "?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"
            loadMovies(urlString: urlString)
        }
       
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "Show Movie Details") {
            let destinationViewController = segue.destination as! FAMovieDetailsViewController
            let cell = sender as! FAMovieTableViewCell
            destinationViewController.movie = cell.movie
            destinationViewController.image = cell.movieImageView.image
        }
    }
    

}

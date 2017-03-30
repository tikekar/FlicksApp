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
    
    let API_KEY: String! = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
    let MOVIE_URL: String! = "https://api.themoviedb.org/3/movie/"
    let SEARCH_URL: String! = "https://api.themoviedb.org/3/search/movie"
    
    var movieFilterType: String? = nil
    var movies: [NSDictionary] = []
    
    var errorMessage: String! = "No Movies Found"
    
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        // add refresh control to table view
        tableView.insertSubview(refreshControl, at: 0)
        let urlString: String! = MOVIE_URL + movieFilterType! + "?api_key=" + API_KEY;
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
                if(error != nil) {
                    self.errorMessage = error?.localizedDescription
                    self.tableView.reloadData()
                }
                if let data = data {
                    if let responseDictionary = try! JSONSerialization.jsonObject(
                        with: data, options:[]) as? NSDictionary {
                        self.movies = responseDictionary["results"] as! [NSDictionary]
                        self.tableView.reloadData()
                    }
                }
                if(self.refreshControl.isRefreshing) {
                    self.refreshControl.endRefreshing()
                }
                
        });
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(self.movies.isEmpty) {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
           // label.center = CGPoint(x: 160, y: 285)
            label.textAlignment = .center
            label.text = errorMessage
            label.numberOfLines = 0
            tableView.backgroundView = label
        }
        else {
            tableView.backgroundView = nil;
        }
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:
            "MovieCell") as! FAMovieTableViewCell
        let movie = movies[indexPath.row]
        cell.setUI(aMovie: movie)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func refreshControlAction(_ refreshControl: UIRefreshControl) {
        let urlString: String! = MOVIE_URL + movieFilterType! + "?api_key=" + API_KEY;
        loadMovies(urlString: urlString)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        var urlString: String! = SEARCH_URL + "?api_key=" + API_KEY + "&query=" + searchBar.text!
        if(searchBar.text == nil) {
            urlString = MOVIE_URL + movieFilterType! + "?api_key=" + API_KEY;
        }
        loadMovies(urlString: urlString)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        let urlString: String! = MOVIE_URL + movieFilterType! + "?api_key=" + API_KEY;
        loadMovies(urlString: urlString)
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(searchText.isEmpty) {
           let urlString: String! = MOVIE_URL + movieFilterType! + "?api_key=" + API_KEY;
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

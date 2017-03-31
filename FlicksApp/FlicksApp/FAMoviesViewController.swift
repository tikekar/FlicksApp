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
    
    // Different movie database urls to fetch movies
    let API_KEY: String! = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
    let MOVIE_URL: String! = "https://api.themoviedb.org/3/movie/"
    let SEARCH_URL: String! = "https://api.themoviedb.org/3/search/movie"
    
    // Set filter type as now_playing or top_rated based on the tab in the tabbar.
    var movieFilterType: String? = nil
    
    // To store the array of movies comming from the server call
    var movies: NSMutableArray = []
    
    // Error message to show when network call fails
    var errorMessage: String! = "No Movies Found"
    var currentPageNumber: Int! = 1
    
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.keyboardDismissMode =  UIScrollViewKeyboardDismissMode.onDrag
        
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        // add refresh control to table view
        tableView.insertSubview(refreshControl, at: 0)
        
        currentPageNumber = 1;
        loadMovies()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true;
    }
    
    func loadMovies() {
        
        var urlString: String! = MOVIE_URL + movieFilterType! + "?api_key=" + API_KEY;
        
        // If searchbar filter text non empty, then use search api url
        if(searchBar.text != nil && !(searchBar.text?.isEmpty)!) {
            urlString = SEARCH_URL + "?api_key=" + API_KEY + "&query=" + searchBar.text!
        }
        urlString = urlString + "&page=" + (currentPageNumber as NSNumber).stringValue
        urlString = urlString.addingPercentEncoding( withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        errorMessage = "No Movies Found"
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
                        if(self.currentPageNumber == 1) {
                            if let array_ = responseDictionary["results"] as? NSArray {
                                self.movies = array_.mutableCopy() as! NSMutableArray
                            }
                            else {
                                self.movies.removeAllObjects()
                            }
                        }
                        else {
                            self.movies.addObjects(from: (responseDictionary["results"] as! NSArray) as! [Any])
                        }
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
    
    // MARK: - TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // When movie view is empty, then show the empty view.
        // It will show the error from the server call if that is the reason for the empty movie set.
        if(self.movies.count == 0) {
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
        cell.setUI(aMovie: movie as! NSDictionary)
        if(indexPath.row == movies.count - 1) {
            currentPageNumber = currentPageNumber + 1;
            loadMovies()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func refreshControlAction(_ refreshControl: UIRefreshControl) {
        currentPageNumber = 1;
        loadMovies()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        currentPageNumber = 1;
        loadMovies()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        currentPageNumber = 1;
        loadMovies()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        currentPageNumber = 1;
        loadMovies()
        
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

//
//  FAMovieDetailsViewController.swift
//  FlicksApp
//
//  Created by Gauri Tikekar on 3/30/17.
//  Copyright © 2017 Gauri Tikekar. All rights reserved.
//

import UIKit

class FAMovieDetailsViewController: UIViewController {
    
    var movie: NSDictionary = [:]
    var image: UIImage!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    @IBOutlet weak var moviePhotoView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        moviePhotoView.alpha = 0.1
        moviePhotoView.image = image
        UIView.animate(withDuration: 0.8) {
            self.moviePhotoView.alpha = 1.0
        }
        
        overviewLabel.text = movie.value(forKey: "overview") as? String
        titleLabel.text = movie.value(forKey: "original_title") as? String
        releaseDate.text = movie.value(forKey: "release_date") as? String

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}

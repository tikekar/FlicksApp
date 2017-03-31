//
//  FAMovieTableViewCell.swift
//  FlicksApp
//
//  Created by Gauri Tikekar on 3/30/17.
//  Copyright © 2017 Gauri Tikekar. All rights reserved.
//

import UIKit
import AFNetworking

class FAMovieTableViewCell: UITableViewCell {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    
    // TODO: Create Movie object in Model and use that instead of accessing dictionary directly
    var movie: NSDictionary = [:]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setUI(aMovie: NSDictionary) {
        movie = aMovie
        descriptionLabel.text = movie.value(forKey: "overview") as? String
        titleLabel.text = movie.value(forKey: "original_title") as? String
        
        
        if let posterPath = movie["poster_path"] as? String {
            let posterBaseUrl = "http://image.tmdb.org/t/p/w500"
            let posterUrl = URL(string: posterBaseUrl + posterPath)
            
            movieImageView.setImageWith(posterUrl!)
        }
        else {
            // No poster image. Can either set to nil (no image) or a default movie poster image
            // that you include as an asset
            movieImageView.image = nil
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        let view = UIView()
        // 244 193 68
        view.backgroundColor = UIColor.init(colorLiteralRed: 244/255, green: 193/255, blue: 68/255, alpha: 0.8)
        self.selectedBackgroundView = view
        // Configure the view for the selected state
    }

}

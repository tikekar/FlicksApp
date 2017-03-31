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
    var movieInfoFrame: CGRect!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var movieInfoView: UIView!
    
    @IBOutlet weak var moviePhotoView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(self.viewDragged(gestureRecognizer:)))
        movieInfoView.addGestureRecognizer(gesture)
        movieInfoView.isUserInteractionEnabled = true
        
        setMovieInfo()
        moviePhotoView.alpha = 0.1
        moviePhotoView.image = image
        UIView.animate(withDuration: 0.8) {
            self.moviePhotoView.alpha = 1.0
        }
        
    }
    
    func setMovieInfo() {
        
        overviewLabel.text = movie.value(forKey: "overview") as? String
        overviewLabel.sizeToFit()
        
        movieInfoView.frame = CGRect(x: movieInfoView.frame.origin.x, y: movieInfoView.frame.origin.y, width: movieInfoView.frame.size.width, height: overviewLabel.frame.size.height + 80)
        UIView.animate(withDuration: 0.7) { 
            self.movieInfoView.frame = CGRect(x: self.movieInfoView.frame.origin.x, y: self.view.frame.size.height - self.movieInfoView.frame.size.height - 120, width: self.movieInfoView.frame.size.width, height: self.movieInfoView.frame.size.height)
            self.movieInfoFrame = self.movieInfoView.frame
        }
        titleLabel.text = movie.value(forKey: "original_title") as? String
        releaseDate.text = movie.value(forKey: "release_date") as? String
        if(releaseDate.text != nil) {
            let myFormatter = DateFormatter()
            myFormatter.dateFormat = "yyyy-MM-dd"
            let date_ = myFormatter.date(from: releaseDate.text!)! as Date
            myFormatter.dateFormat = "MMMM, dd YYYY"
            releaseDate.text = myFormatter.string(from: date_)
        }

    }
    
    // http: //stackoverflow.com/questions/25503537/swift-uigesturerecogniser-follow-finger
    func viewDragged(gestureRecognizer: UIPanGestureRecognizer) {
        if(gestureRecognizer.state == UIGestureRecognizerState.ended)
        {
            setMovieViewBack()
            return
        }
        let translation = gestureRecognizer.translation(in: self.view)
        // note: 'view' is optional and need to be unwrapped
        gestureRecognizer.view!.center = CGPoint(x: gestureRecognizer.view!.center.x + translation.x, y: gestureRecognizer.view!.center.y + translation.y)
        gestureRecognizer.setTranslation(CGPoint.zero, in: self.view)
        
    }
    
    func setMovieViewBack() {
        UIView.animate(withDuration: 0.3) {
            self.movieInfoView.frame = self.movieInfoFrame
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}

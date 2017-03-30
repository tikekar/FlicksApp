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
    
    @IBOutlet weak var moviePhotoView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        moviePhotoView.image = image

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  FANowPlayingViewController.swift
//  FlicksApp
//
//  TabBar images from iconBeast
//
//
//  Created by Gauri Tikekar on 3/30/17.
//  Copyright © 2017 Gauri Tikekar. All rights reserved.
//

import UIKit

class FANowPlayingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "Movies View") {
            let secondViewController = segue.destination  as! FAMoviesViewController
            secondViewController.movieFilterType = "now_playing"
        }
    }
    

}

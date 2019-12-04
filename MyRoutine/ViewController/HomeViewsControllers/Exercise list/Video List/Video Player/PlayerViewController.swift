//
//  PlayerViewController.swift
//  MyRoutine
//
//  Created by Gabriel on 1/19/19.
//  Copyright © 2019 Gabriel. All rights reserved.
//

import UIKit
import YoutubePlayer_in_WKWebView

class PlayerViewController: UIViewController {
    
    @IBOutlet weak var playerView: WKYTPlayerView!
    var loadedVideoUrl = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerView.load(withVideoId: loadedVideoUrl)
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

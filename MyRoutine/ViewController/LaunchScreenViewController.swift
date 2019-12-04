//
//  LaunchScreenViewController.swift
//  MyRoutine
//
//  Created by Gabriel on 1/4/19.
//  Copyright © 2019 Gabriel. All rights reserved.
//

import UIKit

class LaunchScreenViewController: UIViewController, CAAnimationDelegate {

    @IBOutlet weak var productionsLabel: UILabel!
    @IBOutlet weak var gLabel: UILabel!
    @IBOutlet weak var mLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        gLabel.slideInFromDirection(side: kCATransitionFromLeft)
        mLabel.slideInFromDirection(side: kCATransitionFromRight)
        addLetter(wordLength: (4.0/Double("Gabriel".count)), word: "Gabriel", labelName: gLabel)
        addLetter(wordLength: (4.0/Double("Moraes".count)), word: "Moraes", labelName: mLabel)
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            self.productionsLabel.isHidden = false
        }
        Timer.scheduledTimer(timeInterval: 6.0, target: self, selector: #selector(timeToMoveOn), userInfo: nil, repeats: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func addLetter(wordLength: Double, word: String, labelName: UILabel){
        labelName.isHidden = false
        var counting = [Double]()
        for i in stride(from: 0, to: 4.0, by: wordLength) {
            counting.append(i)
            let currentWord = word.prefix(counting.count)
            DispatchQueue.main.asyncAfter(deadline: .now() + i) {
                labelName.text = String(currentWord)
            }
        }
        
    }
    
    @objc func timeToMoveOn() {
        self.performSegue(withIdentifier: "goToLogin", sender: self)
    }

}

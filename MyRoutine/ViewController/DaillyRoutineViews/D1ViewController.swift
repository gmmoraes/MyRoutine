//
//  D1ViewController.swift
//  MyRoutine
//
//  Created by Rafael on 1/6/19.
//  Copyright © 2019 Gabriel. All rights reserved.
//

import UIKit

class D1ViewController: UIViewController {


    @IBOutlet weak var addExerciseBTN: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        let screenSize = UIScreen.main.bounds
        let screenHeight = screenSize.height
        let screenWidth = screenSize.width
        print(Int(screenWidth))
        print(Int(screenHeight))
        //addExerciseBTN.frame.size = CGSize(width: Int(screenWidth), height: Int(screenHeight))

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func toExerciseScreen(_ sender: Any) {
        performSegue(withIdentifier: "addExerciseSegue", sender: self)
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

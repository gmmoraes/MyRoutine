//
//  NewExerciseFormViewController.swift
//  MyRoutine
//
//  Created by Gabriel on 1/7/19.
//  Copyright © 2019 Gabriel. All rights reserved.
//

import UIKit
import CoreData

class NewExerciseFormViewController: UIViewController {
    
    var routine: Workout_Routine?

    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var repsTextField: UITextField!
    @IBOutlet weak var setsTextField: UITextField!
    @IBOutlet weak var exerciseNameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func addExerciseData(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let ad = UIApplication.shared.delegate as! AppDelegate
        let exercises = Exercise(context: context)
        exercises.name = exerciseNameTextField.text
        exercises.rep = repsTextField.text
        exercises.set = setsTextField.text
        

        routine?.mutableSetValue(forKey: "exercise").add(exercises)
        ad.saveContext()
        repsTextField.text = ""
        setsTextField.text = ""
        exerciseNameTextField.text = ""

    }
    
  
}

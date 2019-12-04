//
//  NewRoutineViewController.swift
//  MyRoutine
//
//  Created by Gabriel on 1/6/19.
//  Copyright © 2019 Gabriel. All rights reserved.
//

import UIKit
import CoreData
class NewRoutineViewController: UIViewController {

    private let createExercisesSegue = "addNewExerciseFormSegue"
    
    @IBOutlet weak var doneBtnRoutine: UIButton!
    @IBOutlet weak var routineNameTextField: UITextField!
    
    var newRoutine: Workout_Routine?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func addRoutine(_ sender: UIButton) {
        
        
        guard let enteredText = routineNameTextField?.text else {
            return
        }
        
        if enteredText.isEmpty ||  routineNameTextField?.text == "Routine Name"{
            
            let alert = UIAlertController(title: "Please Type Something", message: "Your entry was left blank.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default) { action in
                
            })
            
            self.present(alert, animated: true, completion: nil)
            
        } else {
            
            guard let entryText = routineNameTextField?.text else {
                return
            }
            
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            newRoutine = Workout_Routine(context: context)
            newRoutine?.name = entryText
            newRoutine?.id = UUID()
            
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            performSegue(withIdentifier: createExercisesSegue, sender: self)
            
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == createExercisesSegue, let newExercisesVC = segue.destination as? NewExerciseFormViewController  {
            newExercisesVC.routine = newRoutine
        }
    }

}

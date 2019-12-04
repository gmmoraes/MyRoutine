//
//  LoadedRoutineExercisesTableViewController.swift
//  MyRoutine
//
//  Created by Gabriel on 1/9/19.
//  Copyright © 2019 Gabriel. All rights reserved.
//

import UIKit
import CoreData

class LoadedRoutineExercisesTableViewController: UITableViewController {
    
    private let createExercisesSegue = "addExerciseToLoadedRoutineSegue"
    private let dataSource = DoubleCellDatasource()
    var routine: Workout_Routine?
    var arrayofExercises = [String]()
    var arrayofReps = [String]()
    var arrayofSets = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Exercise List"
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Exercise")
        request.returnsObjectsAsFaults = false
        request.relationshipKeyPathsForPrefetching = ["workout_routine"]
        request.predicate = NSPredicate(format: "workout_routine == %@", routine!)
        
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                if let workoutHasExercise = data.value(forKey: "name"){
                    arrayofExercises.append(workoutHasExercise as! String)
                }
                if let workoutHasExercise = data.value(forKey: "rep"){
                    arrayofReps.append(workoutHasExercise as! String)
                }
                if let workoutHasExercise = data.value(forKey: "set"){
                    arrayofSets.append(workoutHasExercise as! String)
                }
            }
            
        } catch {
            
            print("Failed")
        }
        
        let addBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didPressRightButton))
        self.navigationItem.rightBarButtonItem = addBarButton

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func didPressRightButton(){
        performSegue(withIdentifier: createExercisesSegue, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == createExercisesSegue, let newExercisesVC = segue.destination as? NewExerciseFormViewController  {
            newExercisesVC.routine = routine
        }
    }

}

extension LoadedRoutineExercisesTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayofExercises.count //videos.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "routineExercisesLoadedCell", for: indexPath)
        
        let nameLabel = UILabel()
        let repLabel = UILabel()
        let setLabel = UILabel()
        
        let screenSize = UIScreen.main.bounds
        let screenHeight = screenSize.height
        let screenWidth = screenSize.width
        tableView.rowHeight = screenHeight/CGFloat(arrayofExercises.count)
        
        func createLabels(label:UILabel, text:String, xNumber:Int, yNumber:Int){
            label.frame = CGRect(x: xNumber, y: yNumber, width:200 , height:100)
            label.textAlignment = .center
            label.textColor = .black
            label.font = UIFont(name: "HelveticaNeue-small", size: CGFloat(15))
            label.text = text
            cell.contentView.addSubview(label)
        }

        
        
        
        if(arrayofExercises.count < indexPath.row){
            createLabels(label:nameLabel, text:"Exercise: No Exercise", xNumber:Int(screenWidth*0.3), yNumber:Int(tableView.rowHeight*0.2))
        }else{
            createLabels(label:nameLabel, text:"Exercise:" + "" + arrayofExercises[indexPath.row], xNumber:Int(screenWidth*0.3), yNumber:Int(tableView.rowHeight*0.2))
        }
        
       if(arrayofReps.count < indexPath.row){
        createLabels(label:setLabel, text:"Reps: 0", xNumber:Int(screenWidth*0.3), yNumber:Int(tableView.rowHeight*0.2)+50)
        }else{
            createLabels(label:setLabel, text:"Reps:" + "" + arrayofReps[indexPath.row], xNumber:Int(screenWidth*0.3), yNumber:Int(tableView.rowHeight*0.2)+50)
        }
        
        if(arrayofSets.count < indexPath.row){
            createLabels(label:repLabel, text:"Sets: 0", xNumber:Int(screenWidth*0.3), yNumber:Int(tableView.rowHeight*0.2)+100)
        }else{
            createLabels(label:repLabel, text:"Sets:" + "" + arrayofSets[indexPath.row], xNumber:Int(screenWidth*0.3), yNumber:Int(tableView.rowHeight*0.2)+100)
        }
        
        

        
        return cell
    }
    
}


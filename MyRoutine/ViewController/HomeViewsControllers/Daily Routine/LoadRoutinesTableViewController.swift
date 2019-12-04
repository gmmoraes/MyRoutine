//
//  LoadRoutinesTableViewController.swift
//  MyRoutine
//
//  Created by Gabriel on 1/8/19.
//  Copyright © 2019 Gabriel. All rights reserved.
//

import UIKit
import CoreData

class LoadRoutinesTableViewController: UITableViewController {

    private let nextSegue = "listExercisesLoadedSegue"
    private let dataSource = DoubleCellDatasource()
    var arrayOfRoutines = [String]()
    var arrayOfWorkout = [Workout_Routine?]()
    var loadedRoutine: Workout_Routine?
    var previousSegue: String?
    var newLog: Log?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Routine List"
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Workout_Routine")
        request.returnsObjectsAsFaults = false
        request.relationshipKeyPathsForPrefetching = ["exercise"]
        
        //Navigation
        let addBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didPressRightButton))
        

        self.navigationItem.rightBarButtonItem = addBarButton

        
        do {
            let result = try context.fetch(request)
            
            for data in result as! [NSManagedObject] {
                arrayOfRoutines.append(data.value(forKey: "name") as! String)
                arrayOfWorkout.append(data as! Workout_Routine)


            }
            
        } catch {
            
            print("Failed")
        }
        
        if(arrayOfRoutines.count < 1){
            dataSource.names = ["No Routines"]
        }
        dataSource.names = arrayOfRoutines
        dataSource.identifier = "routineListCell"
        tableView.dataSource = dataSource


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func makeBackButton() -> UIButton {
        let backButtonImage = UIImage(named: "backButton2")?.withRenderingMode(.alwaysTemplate)
        let backButton = UIButton(type: .custom)
        backButton.setImage(backButtonImage, for: .normal)
        backButton.setTitle("  Back", for: .normal)

        backButton.setTitleColor(.black, for: .normal)
        backButton.addTarget(self, action: #selector(self.backButtonPressed), for: .touchUpInside)
        return backButton
    }

    
    @objc func backButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func didPressRightButton(){
        performSegue(withIdentifier: "addRoutineSegue", sender: self)
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(previousSegue == "addLogSegue"){
            let date = Date()
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let ad = UIApplication.shared.delegate as! AppDelegate
            newLog = Log(context: context)
            newLog?.name = "Trained" + " " + arrayOfRoutines[indexPath.row]
            newLog?.date_added = date
            loadedRoutine?.mutableSetValue(forKey: "log").add(newLog)
            ad.saveContext()
            performSegue(withIdentifier: "logListFromRoutinesSegue", sender: self)
        }else{
            loadedRoutine = arrayOfWorkout[indexPath.row]!
            performSegue(withIdentifier: nextSegue, sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == nextSegue, let LoadedRoutineExercisesVC = segue.destination as? LoadedRoutineExercisesTableViewController  {
            LoadedRoutineExercisesVC.routine = loadedRoutine
        }
    }
    

}

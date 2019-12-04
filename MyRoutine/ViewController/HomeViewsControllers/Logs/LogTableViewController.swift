//
//  LogTableViewController.swift
//  MyRoutine
//
//  Created by Gabriel on 1/12/19.
//  Copyright © 2019 Gabriel. All rights reserved.
//

import UIKit
import CoreData

class LogTableViewController: UITableViewController {

    private let dataSource = DoubleCellDatasource()
    private let createExercisesSegue = "addLogSegue"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var arrayOfLogs = [String]()
        var arrayOfLogsDates = [Date]()
        var arrayForCell = [String]()
        
        //fetch data from logs entity
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Log")
        request.returnsObjectsAsFaults = false
        
        
        do {
            let result = try context.fetch(request)
            
            for data in result as! [NSManagedObject] {
                arrayOfLogs.append(data.value(forKey: "name") as! String)
                arrayOfLogsDates.append(data.value(forKey: "date_added") as! Date)
            }
            
        } catch {
            
            print("Failed")
        }
        
        
        
        if(arrayOfLogs.count < 1){
           dataSource.names = ["No logs saved"]
        }else{
            for index in 0...(arrayOfLogs.count - 1) {
                let formatter = DateFormatter()
                formatter.dateFormat = "dd.MM.yyyy"
                let result = formatter.string(from: arrayOfLogsDates[index])
                //
                arrayForCell.append(arrayOfLogs[index] + " " + "at" + " " + result)
            }
            dataSource.names = arrayForCell
        }
        //dataSource.names = [
        dataSource.identifier = "logCell"
        tableView.dataSource = dataSource

        //Navigation
        let addBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didPressRightButton))
        self.navigationItem.rightBarButtonItem = addBarButton
    
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func didPressRightButton(){
        performSegue(withIdentifier: createExercisesSegue, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == createExercisesSegue, let LoadedRoutineExercisesVC = segue.destination as? LoadRoutinesTableViewController  {
            LoadedRoutineExercisesVC.previousSegue = "addLogSegue"
        }
    }
    

}

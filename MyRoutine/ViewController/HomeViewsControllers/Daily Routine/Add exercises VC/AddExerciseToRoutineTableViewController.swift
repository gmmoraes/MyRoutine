//
//  AddExerciseToRoutineTableViewController.swift
//  MyRoutine
//
//  Created by Gabriel on 1/7/19.
//  Copyright © 2019 Gabriel. All rights reserved.
//

import UIKit

class AddExerciseToRoutineTableViewController: UITableViewController {
    
    var names = ["Add exercise", "Go back to home"]
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddExerciseToRoutineCell", for: indexPath)

        cell.textLabel?.text = names[indexPath.row]

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Go back to home screen
        if(indexPath.row == 0){
            performSegue(withIdentifier: "addNewExerciseFormSegue", sender: self)
        } else if(indexPath.row == 1){
            self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        }
    }

}

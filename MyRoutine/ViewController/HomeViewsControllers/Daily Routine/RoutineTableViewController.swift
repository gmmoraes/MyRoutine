//
//  RoutineTableViewController.swift
//  MyRoutine
//
//  Created by Rafael on 1/8/19.
//  Copyright © 2019 Gabriel. All rights reserved.
//

import UIKit

class RoutineTableViewController: UITableViewController {

    private let dataSource = DoubleCellDatasource()
    //var names = ["Routine list", "Add new routine"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource.names = ["Routine list", "Add new routine"]
        dataSource.identifier = "routineCell"
        
        tableView.dataSource = dataSource
        
        let screenSize = UIScreen.main.bounds
        let screenHeight = screenSize.height
        self.tableView.rowHeight = screenHeight/2
        
        //Navigation
        self.navigationItem.title = title
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: makeBackButton())
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Backbutton creation
    func makeBackButton() -> UIButton {
        let backButtonImage = UIImage(named: "backButton2")?.withRenderingMode(.alwaysTemplate)
        let backButton = UIButton(type: .custom)
        backButton.setImage(backButtonImage, for: .normal)
        backButton.setTitle("  Back", for: .normal)
        //backButton.setTitleColor(UIColor(red: 0/255, green: 123/255, blue: 255/255,  alpha: 2.0), for: .normal)
        backButton.setTitleColor(.black, for: .normal)
        backButton.addTarget(self, action: #selector(self.backButtonPressed), for: .touchUpInside)
        return backButton
    }
    
    @objc func backButtonPressed() {
        dismiss(animated: true, completion: nil)
        //        navigationController?.popViewController(animated: true)
    }

    // MARK: - Table view data source

   /** override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "routineCell", for: indexPath)

        cell.textLabel?.text = names[indexPath.row]
        
        return cell
    }*/
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Go back to home screen
        if(indexPath.row == 1){
            performSegue(withIdentifier: "addNewRoutineSegue", sender: self)
        } else if(indexPath.row == 0){
            performSegue(withIdentifier: "loadRoutinesSegue", sender: self)
            //self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        }
    }


}

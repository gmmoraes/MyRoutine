//
//  ExerciseListTableViewController.swift
//  MyRoutine
//
//  Created by Gabriel on 1/13/19.
//  Copyright © 2019 Gabriel. All rights reserved.
//

import UIKit
import Siesta

class ExerciseListTableViewController: UITableViewController {

    //private let dataSource = DoubleCellDatasource()
    
    //private var exercises: [ExercisesWger] = [] {
    /**private var arrayOfExercisesNames: [String] = [] {
        didSet {
            DispatchQueue.main.async{
                self.tableView.reloadData()
            }
        }
    }**/
    
    private var arrayOfExercisesNames: [String] = []
    
    var exerciseName = String()
    typealias JSONDictionary = [String: Any]
    typealias QueryResult = ([ExerxiseList]?, String) -> ()
    var exercises: [ExerxiseList] = []
    var errorMessage = ""
    let queryService = QueryService()
    
    
    //Wheel spinner
    var activityIndicatorView: UIActivityIndicatorView!
    var rows: [String]?
    let dispatchQueue = DispatchQueue(label: "Example Queue")
    
    override func loadView() {
        super.loadView()
        activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        tableView.backgroundView = activityIndicatorView
    }
    
    
    //var arrayOfExercisesNames = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
         title = "Exercise List"
        //exerciseListResource = WgerApi.sharedInstance.exerciseList()
        /**wgerApi.exerciseList().addObserver(self)**/
        //print(exerciseListResource)

        
        func updateSearchResults(_ data: Data) {
            var response: JSONDictionary?
            exercises.removeAll()
            
            do {
                response = try JSONSerialization.jsonObject(with: data, options: []) as? JSONDictionary
            } catch let parseError as NSError {
                errorMessage += "JSONSerialization error: \(parseError.localizedDescription)\n"
                return
            }
            guard let array = response!["results"] as? [Any] else {
                errorMessage += "Dictionary does not contain results key\n"
                return
            }
            var index = 0
            for exercisesDictionary in array {
                if let exercisesDictionary = exercisesDictionary as? JSONDictionary,
                    
                    let name_original = exercisesDictionary["name_original"] as? String {
                    exercises.append(ExerxiseList(name_original:name_original))
                    arrayOfExercisesNames.append(name_original)
                    index += 1
                } else {
                    errorMessage += "Problem parsing trackDictionary\n"
                }
            }
        }
        
        queryService.getSearchResults(UrlString: "https://wger.de/api/v2/exercise/?format=json",queryPart: "&license_author=wger.de&limit=500", updateFunction:updateSearchResults){ results, errorMessage in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            self.activityIndicatorView.stopAnimating()
            self.tableView.reloadData()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if (rows == nil) {
            activityIndicatorView.startAnimating()
            
            tableView.separatorStyle = .none
            
            dispatchQueue.async {
                Thread.sleep(forTimeInterval: 3)
            }
        }
        
        //wgerApi.exerciseList().loadIfNeeded()
    }
    
    


}

// MARK: - UITableViewDataSource
extension ExerciseListTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfExercisesNames.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "exerciseListCell", for: indexPath)
        cell.textLabel?.text = arrayOfExercisesNames[indexPath.row]
        //cell.imageView.image = someImage;
        let screenSize = UIScreen.main.bounds
        let screenHeight = screenSize.height
        tableView.rowHeight = screenHeight/CGFloat(5)//arrayOfExercisesNames.count
        
        cell.layer.borderWidth = 0.5
        let gray = UIColor(red: 220.0/255.0, green: 220.0/255.0, blue: 220.0/255.0, alpha: 1.0)
        cell.layer.borderColor = gray.cgColor
        
        return cell
    }
    
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //exerciseName = (cell.textLabel?.text)!
        exerciseName = arrayOfExercisesNames[indexPath.row]
        performSegue(withIdentifier: "goTovideoSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goTovideoSegue", let LoadedRoutineExercisesVC = segue.destination as? VideoListTableViewController  {
            LoadedRoutineExercisesVC.loadedExerciseName = exerciseName
            
        }
    }
    
    
}
    





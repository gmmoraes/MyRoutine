//
//  HomeTableViewController.swift
//  MyRoutine
//
//  Created by Gabriel on 1/6/19.
//  Copyright © 2019 Gabriel. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    var names = ["Daily Log", "Routines", "Exercise list"]
    var images =  [UIImage(named: "addExercise3")!,UIImage(named: "routine3")!,UIImage(named: "exerciseList2")!]

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath)
        let imgView = UIImageView(frame: CGRect(x: cell.frame.width*0.02, y: 5, width: (cell.frame.width) - (cell.frame.width*0.05), height: cell.frame.height - 5))

        imgView.backgroundColor = UIColor.clear
        imgView.layer.cornerRadius = 8.0
        imgView.layer.masksToBounds = true
        imgView.image = images[indexPath.row]
        
        let strokeTextAttributes: [NSAttributedStringKey : Any] = [
            NSAttributedStringKey.strokeColor : UIColor.black,
            NSAttributedStringKey.foregroundColor : UIColor.white,
            NSAttributedStringKey.strokeWidth : -2.0,
            ]
        
        
        
        let label = UILabel()
        label.frame = CGRect(x:0, y:0, width:imgView.frame.width , height:imgView.frame.height)
        label.text = names[indexPath.row]
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont(name: "HelveticaNeue-medium", size: CGFloat(49))
        label.attributedText = NSAttributedString(string: names[indexPath.row], attributes: strokeTextAttributes)
        
        
        cell.contentView.addSubview(imgView)
        cell.contentView.addSubview(label)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        (view as! UITableViewHeaderFooterView).backgroundView?.backgroundColor = UIColor.black.withAlphaComponent(0.4)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.row == 0){
            performSegue(withIdentifier: "logsSegue", sender: self)
        }else if(indexPath.row == 1){
            performSegue(withIdentifier: "dailyRoutineSegue", sender: self)
        }else if(indexPath.row == 2){
            performSegue(withIdentifier: "exerciseListSegue", sender: self)
        }

    }

}

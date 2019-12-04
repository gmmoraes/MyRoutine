//
//  doubleCellDatasource.swift
//  MyRoutine
//
//  Created by Gabriel on 1/8/19.
//  Copyright © 2019 Gabriel. All rights reserved.
//

import Foundation

import UIKit

class DoubleCellDatasource: NSObject, UITableViewDataSource {
    
    var names = [String]()
    var identifier = String()
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier)!
        
        cell.textLabel?.text = names[indexPath.row]
        
        let screenSize = UIScreen.main.bounds
        let screenHeight = screenSize.height
        tableView.rowHeight = screenHeight/CGFloat(names.count)
        
        return cell
    }
    
    
    
}



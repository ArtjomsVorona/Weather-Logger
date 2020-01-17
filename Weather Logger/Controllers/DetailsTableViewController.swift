//
//  DetailsTableViewController.swift
//  Weather Logger
//
//  Created by Artjoms Vorona on 17/01/2020.
//  Copyright © 2020 Artjoms Vorona. All rights reserved.
//

import UIKit

class DetailsTableViewController: UITableViewController {
    
    var weatherData: WeatherData?
    var detailsDict = [String: String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareToDisplay()
    }
    
    func prepareToDisplay() {
        guard let weatherData = weatherData else { return }
        
        let mirror = Mirror(reflecting: weatherData)
        for child in mirror.children {
            detailsDict[child.label!] = "\(child.value)"
        }
        
        tableView.reloadData()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return detailsDict.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsCell", for: indexPath)
        
        let titleArray = Array(detailsDict.keys.sorted())
        let key = titleArray[indexPath.row]

        cell.textLabel?.text = key
        cell.detailTextLabel?.text = String(detailsDict[key]!)

        return cell
    }

}

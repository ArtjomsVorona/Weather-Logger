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
        
        guard let weatherData = weatherData else { return }
        
        detailsDict = weatherData.getDetailsDict()
        
        tableView.reloadData()
    }
    


    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailsDict.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsCell", for: indexPath)
        
        let titleArray = Array(detailsDict.keys.sorted())
        let key = titleArray[indexPath.row]

        cell.textLabel?.text = key
        cell.textLabel?.textColor = #colorLiteral(red: 0.3859816492, green: 0.5554968715, blue: 0.6556989551, alpha: 1)
        
        cell.detailTextLabel?.text = String(detailsDict[key]!)
        cell.detailTextLabel?.textColor = #colorLiteral(red: 0.4656865001, green: 0.7002133727, blue: 0.829667151, alpha: 1)

        return cell
    }

}//end class

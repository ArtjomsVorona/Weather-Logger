//
//  SavedTableViewController.swift
//  Weather Logger
//
//  Created by Artjoms Vorona on 14/01/2020.
//  Copyright © 2020 Artjoms Vorona. All rights reserved.
//

import UIKit

class SavedTableViewController: UITableViewController {
    
    let userDefaults = UserDefaults.standard
    var savedWeatherData = [WeatherData]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    
    func loadData() {
        guard let savedData = userDefaults.object(forKey: "savedWeatherData") as? Data else {
            print("No data saved in userDefaults")
            return
        }
        
        guard let decodedData = try? PropertyListDecoder().decode([WeatherData].self, from: savedData) else {
            print("Unable to decode data")
            return
        }
        savedWeatherData = decodedData
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedWeatherData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SavedCell", for: indexPath)

        let weatherData = savedWeatherData[indexPath.row]
        
        cell.textLabel?.text = "\(weatherData.name) \(weatherData.temp) + °C"
        cell.detailTextLabel?.text = "\(weatherData.requestTime!)"

        return cell
    }


    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

}

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
    
    let removeAllBarButtonItem = UIBarButtonItem.init(title: "Remove all", style: .plain, target: self, action: #selector(deleteAll))
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        loadData()
    }
    
    //MARK: Methods
    @objc func deleteAll() {
        let alert = UIAlertController(title: "Are you sure you want to delete all data?", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (alert) in
            self.savedWeatherData.removeAll()
            self.tableView.reloadData()
            self.saveData()
            super.setEditing(false, animated: true)
            self.navigationItem.rightBarButtonItem = nil
            self.autoDismissAlert(title: "Deleted!")
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: UserDefaults methods
    func saveData() {
        userDefaults.set(try? PropertyListEncoder().encode(savedWeatherData), forKey: "savedWeatherData")
    }
    
    func loadData() {
        guard let savedData = userDefaults.object(forKey: "savedWeatherData") as? Data else {
            print("ViewController: No data saved in userDefaults")
            return
        }
        
        guard let decodedData = try? PropertyListDecoder().decode([WeatherData].self, from: savedData) else {
            print("ViewController: Unable to decode data")
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
        
        cell.textLabel?.text = "\(weatherData.name) \(weatherData.temp) °C"
        cell.textLabel?.textColor = #colorLiteral(red: 0.3859816492, green: 0.5554968715, blue: 0.6556989551, alpha: 1)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        cell.detailTextLabel?.text = dateFormatter.string(from: weatherData.requestTime)
        cell.detailTextLabel?.textColor = #colorLiteral(red: 0.4656865001, green: 0.7002133727, blue: 0.829667151, alpha: 1)
        
        if weatherData.weatherIcon != "" {
            cell.imageView?.image = UIImage(named: weatherData.weatherIcon)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alert = UIAlertController(title: "Are you sure you want to delete this weather data?", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (alert) in
                self.savedWeatherData.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
                self.saveData()
                if self.savedWeatherData.count == 0 {
                    super.setEditing(false, animated: true)
                    self.navigationItem.rightBarButtonItem = nil
                }
                self.autoDismissAlert(title: "Deleted")
            }))
            
            present(alert, animated: true, completion: nil)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        if editing {
            super.setEditing(true, animated: true)
            if savedWeatherData.count > 1 {
                self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Remove all", style: .plain, target: self, action: #selector(deleteAll))
            }
        } else {
            super.setEditing(false, animated: true)
            self.navigationItem.rightBarButtonItem = nil
        }
    }
    
    //MARK: Navigations
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "DetailsSegueTVC" else { return }
        guard let navController = segue.destination as? UINavigationController else { return }
        guard let detailsTableVC = navController.topViewController as? DetailsTableViewController else { return }
        
        if let index = tableView.indexPathForSelectedRow?.row {
            detailsTableVC.weatherData = savedWeatherData[index]
        }
    }
    
}//end class

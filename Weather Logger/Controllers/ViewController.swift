//
//  ViewController.swift
//  Weather Logger
//
//  Created by Artjoms Vorona on 14/01/2020.
//  Copyright © 2020 Artjoms Vorona. All rights reserved.
//

import Alamofire
import UIKit

class ViewController: UIViewController {
    
    var weatherData = WeatherData()
    var detailsDict = [String: Int]()
    var savedWeatherData = [WeatherData]()
    
    var userDefaults = UserDefaults.standard
    
    let diffFromFtoC = 273.15

    let basicApiUrlString = "https://api.openweathermap.org/data/2.5/weather?q="
    let apiKey = "bba69a7f8abb8f448add461e26add23c"
    let latitude = "56.9496"
    let longitude = "24.1052"
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var requestTimeLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialViewSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    
    @IBAction func updateAndSaveWetherDataTapped(_ sender: UIButton) {
        print("Refreshh tapped")
        getWeatherData(latitude: latitude, longitude: longitude)
    }
    
    func getWeatherData(latitude: String, longitude: String) {
        let url = URL(string: basicApiUrlString)!
        let parameters = ["appid": apiKey, "lat": latitude, "lon": longitude]
        
        AF.request(url, method: .get, parameters: parameters).responseJSON { (response) in
            if response.value != nil {
                self.parse(json: response.value!)
            }
        }
    }//end getWeatherData
    
    func parse(json: Any) {
//        print(json)
        
        guard let dictionary = json as? [String: Any] else {
            print("Unable to parse json")
            return
        }
        
        if let weatherArray = dictionary["weather"] as? [[String: Any]] {
            for (key, value) in weatherArray[0] {
                switch key {
                case "id":
                    weatherData.weatherId = value as! Int
                case "main":
                    weatherData.weatherMain = value as! String
                case "description":
                    weatherData.weatherDescription = value as! String
                case "icon":
                    weatherData.weatherIcon = value as! String
                default:
                    break
                }
            }
        }
        
        if let mainDict = dictionary["main"] as? [String: Double] {
            for (key, value) in mainDict {
                switch key {
                case "temp":
                    weatherData.temp = Int(value - diffFromFtoC)
                case "feels_like":
                    weatherData.feelsLike = Int(value - diffFromFtoC)
                    detailsDict["Feels like °C"] = Int(value - diffFromFtoC)
                case "temp_min":
                    weatherData.feelsLike = Int(value - diffFromFtoC)
                    detailsDict["Temperature min °C"] = Int(value - diffFromFtoC)
                case "temp_max":
                    weatherData.tempMax = Int(value - diffFromFtoC)
                    detailsDict["Temperature max °C"] = Int(value - diffFromFtoC)
                case "pressure":
                    weatherData.tempMax = Int(value)
                    detailsDict["Pressure"] = Int(value)
                case "humidity":
                    weatherData.tempMax = Int(value)
                    detailsDict["Humidity"] = Int(value)
                default:
                    break
                }
            }
        }
        
        for (key, value) in dictionary {
            if key == "name" {
                weatherData.name = value as! String
            }
        }
        
        weatherData.requestTime = Date()
        updateView(data: weatherData)
        saveData()

    }//end parse
    
    func updateView(data: WeatherData) {
        
        cityNameLabel.text = data.name
        weatherDescriptionLabel.text = data.weatherDescription.capitalized
        tempLabel.text = String(Int(data.temp)) + " °C"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
//        requestTimeLabel.text = dateFormatter.string(from: data.requestTime)
        requestTimeLabel.text = "\(data.requestTime!)"
        
        tableView.reloadData()
    }
    
    func initialViewSetup() {
        cityNameLabel.text = "-"
        weatherDescriptionLabel.text = ""
        tempLabel.text = "- °C"
        requestTimeLabel.text = ""
    }
    
    func saveData() {
        savedWeatherData.insert(weatherData, at: 0)
        userDefaults.set(try? PropertyListEncoder().encode(savedWeatherData), forKey: "savedWeatherData")
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
    }
    
}//end class

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        detailsDict.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailsCell", for: indexPath)
        
        cell.textLabel?.text = Array(detailsDict.keys)[indexPath.row]
        cell.textLabel?.textColor = #colorLiteral(red: 0.4656865001, green: 0.7002133727, blue: 0.829667151, alpha: 1)
        cell.textLabel?.font = UIFont.systemFont(ofSize: 12)
        
        cell.detailTextLabel?.text = String(Array(detailsDict.values)[indexPath.row])
        cell.detailTextLabel?.textColor = #colorLiteral(red: 0.3859816492, green: 0.5554968715, blue: 0.6556989551, alpha: 1)
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 15)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}//end extension


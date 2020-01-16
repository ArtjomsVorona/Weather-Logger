//
//  ViewController.swift
//  Weather Logger
//
//  Created by Artjoms Vorona on 14/01/2020.
//  Copyright © 2020 Artjoms Vorona. All rights reserved.
//

import Alamofire
import CoreLocation
import UIKit

class ViewController: UIViewController {

    var detailsDict = [String: Int]()
    var weatherData: WeatherData!
    var savedWeatherData = [WeatherData]()
    
    var userDefaults = UserDefaults.standard
    var jsonParser = JsonParser()
    
    var locationManager = CLLocationManager()

    var latitude: String!
    var longitude: String!
    
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
        locationManagerSetup()
        loadData()
    }

    //MARK: IBActions
    
    @IBAction func shareBarButtonTapped(_ sender: UIBarButtonItem) {
        if let weatherData = weatherData {
            shareCurrent(weatherData: weatherData)
        } else {
            basicAlert(title: "No weather data to share.", message: nil)
        }
    }
    
    @IBAction func updateAndSaveWetherDataTapped(_ sender: UIButton) {
        let urlString = Api().basicApiUrlString
        let apiKey = Api().apiKey
        let url = URL(string: urlString)!
        
        guard NetworkReachabilityManager()!.isReachable else {
            goToSettingsAlert(title: "Network is not reacheable.", message: "Please check your internet connection.")
            return
        }
        
        guard latitude != nil, longitude != nil else {
            goToSettingsAlert(title: "Location is not available.", message: "Please check your location access settings.")
            return
        }
        
        let parameters = ["appid": apiKey, "lat": latitude!, "lon": longitude!]
        getWeatherData(url: url, parameters: parameters)
    }

    //MARK: Networking
    func getWeatherData(url: URL, parameters: [String: String]) {
        AF.request(url, method: .get, parameters: parameters).responseJSON { (response) in
            if response.value != nil {
                self.weatherData = self.jsonParser.parse(json: response.value!)
//                self.weatherData = jsonResult.weatherData
                
                self.updateView(data: self.weatherData)
                self.saveData(self.weatherData)
            } else {
                print("AF reuest error: \(String(describing: response.error))")
            }
        }
    }//end getWeatherData
    
    //MARK: View functions
    func updateView(data: WeatherData) {
        cityNameLabel.text = data.name
        weatherDescriptionLabel.text = data.weatherDescription.capitalized
        tempLabel.text = String(Int(data.temp)) + " °C"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        requestTimeLabel.text = dateFormatter.string(from: data.requestTime)
        
        detailsUpdate()
        tableView.reloadData()
    }
    
    func detailsUpdate() {
            detailsDict["Feels like °C"] = weatherData.feelsLike
            detailsDict["Temperature min °C"] = weatherData.tempMin
            detailsDict["Temperature max °C"] = weatherData.tempMax
            detailsDict["Pressure"] = weatherData.pressure
            detailsDict["Humidity"] = weatherData.humidity
    }
    
    func initialViewSetup() {
        cityNameLabel.text = "-"
        weatherDescriptionLabel.text = ""
        tempLabel.text = "- °C"
        requestTimeLabel.text = ""
    }


    //MARK: User defaults functions
    func saveData(_ weatherData: WeatherData) {
        savedWeatherData.insert(weatherData, at: 0)
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
    }
}//end class

extension ViewController: CLLocationManagerDelegate {
    func locationManagerSetup() {
        longitude = nil
        longitude = nil
    
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last!

        if location.horizontalAccuracy > 0 {
            self.locationManager.stopUpdatingLocation()
            longitude = String(location.coordinate.longitude)
            latitude = String(location.coordinate.latitude)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager error: \(error.localizedDescription)")
    }
}//end extension - CLLocationManagerDelegate

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        detailsDict.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailsCell", for: indexPath)
        
        let titleArray = Array(detailsDict.keys.sorted())
        let key = titleArray[indexPath.row]
        
        cell.textLabel?.text = key
        cell.textLabel?.textColor = #colorLiteral(red: 0.4656865001, green: 0.7002133727, blue: 0.829667151, alpha: 1)
        cell.textLabel?.font = UIFont.systemFont(ofSize: 12)
        
        cell.detailTextLabel?.text = String(detailsDict[key]!)
        cell.detailTextLabel?.textColor = #colorLiteral(red: 0.3859816492, green: 0.5554968715, blue: 0.6556989551, alpha: 1)
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 15)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}//end extension - TableView


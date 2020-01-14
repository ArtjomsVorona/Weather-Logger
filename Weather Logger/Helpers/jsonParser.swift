//
//  JsonParser.swift
//  Weather Logger
//
//  Created by Artjoms Vorona on 14/01/2020.
//  Copyright © 2020 Artjoms Vorona. All rights reserved.
//

import Foundation

class JsonParser{
    let diffFromFtoC = 273.15
    
    func parse(json: Any) -> (weatherData: WeatherData, detailsDict: [String: Int]) {
        var weatherData = WeatherData()
        var detailsDict = [String: Int]()
    //        print(json)
            
            guard let dictionary = json as? [String: Any] else {
                print("Unable to parse json")
                return (weatherData, detailsDict)
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
            return (weatherData, detailsDict)

        }//end parse
}


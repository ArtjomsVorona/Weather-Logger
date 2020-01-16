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
    
    func parse(json: Any) -> WeatherData {
        var weatherData = WeatherData()
    //        print(json)
            
            guard let dictionary = json as? [String: Any] else {
                print("Unable to parse json")
                return weatherData
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
                    case "temp_min":
                        weatherData.tempMin = Int(value - diffFromFtoC)
                    case "temp_max":
                        weatherData.tempMax = Int(value - diffFromFtoC)
                    case "pressure":
                        weatherData.pressure = Int(value)
                    case "humidity":
                        weatherData.humidity = Int(value)
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
            return weatherData

        }//end parse
}


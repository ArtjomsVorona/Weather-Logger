//
//  WeatherData.swift
//  Weather Logger
//
//  Created by Artjoms Vorona on 14/01/2020.
//  Copyright © 2020 Artjoms Vorona. All rights reserved.
//

import Foundation

struct WeatherData: Codable {

    var weatherId: Int = 0
    var weatherMain: String = ""
    var weatherDescription: String = ""
    var weatherIcon: String = ""
    
    //main
    var temp: Int = 0
    var feelsLike: Int = 0
    var tempMin: Int = 0
    var tempMax: Int = 0
    var pressure: Int = 0
    var humidity: Int = 0
    
    var name: String = ""
    
    //additional data, not from weather api json
    var requestTime = Date()
}

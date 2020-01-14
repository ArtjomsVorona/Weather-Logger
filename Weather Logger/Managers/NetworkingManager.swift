//
//  NetworkingManager.swift
//  Weather Logger
//
//  Created by Artjoms Vorona on 14/01/2020.
//  Copyright © 2020 Artjoms Vorona. All rights reserved.
//

import Alamofire
import UIKit

class NetworkingManager {
    
    let basicApiUrlString = "https://api.openweathermap.org/data/2.5/weather?q="
    let apiKey = "bba69a7f8abb8f448add461e26add23c"
    
    func getWeatherData(latitude: String, longitude: String) {
        let url = URL(string: basicApiUrlString)!
        let parameters = ["appid": apiKey, "lat": latitude, "lon": longitude]
        
        AF.request(url, method: .get, parameters: parameters).responseJSON { (response) in
            if response.value != nil {
            }
        }
    }//end getWeatherData
    
}




//
//  PropertyNames-Ext.swift
//  Weather Logger
//
//  Created by Artjoms Vorona on 19/01/2020.
//  Copyright © 2020 Artjoms Vorona. All rights reserved.
//

import UIKit

extension UIViewController {
    func getReadableProperty(name: String) -> String {
        var returnString = ""
        switch name {
        case "weatherId":
            returnString = "Weather ID"
        case "weatherMain":
            returnString = "Weather Main"
        case "weatherDescription":
            returnString = "Weather Description"
        case "weatherIcon":
            returnString = "Weather Icon"
        case "temp":
            returnString = "Current temperature °C"
        case "feelsLike":
            returnString = "Feels like °C"
        case "tempMin":
            returnString = "Temperature min °C"
        case "tempMax":
            returnString = "Temperature max °C"
        case "pressure":
            returnString = "Pressure hPa"
        case "humidity":
            returnString = "Humidity %"
        case "name":
            returnString = "Location name"
        case "requestTime":
            returnString = "Request Time"
        default:
            returnString = name
        }
        return returnString
    }
    
}

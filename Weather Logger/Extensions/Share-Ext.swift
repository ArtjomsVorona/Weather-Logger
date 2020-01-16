//
//  Share-Ext.swift
//  Weather Logger
//
//  Created by Artjoms Vorona on 15/01/2020.
//  Copyright © 2020 Artjoms Vorona. All rights reserved.
//

import UIKit

extension UIViewController {
    func shareCurrent(weatherData: WeatherData) {
        let text = "Hey! \nLook, current temperature in \(weatherData.name) is \(weatherData.temp) °C."
        let activityVC = UIActivityViewController(activityItems: [text], applicationActivities: nil)
        present(activityVC, animated: true, completion: nil)
    }
}
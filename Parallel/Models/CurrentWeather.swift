//
//  CurrentWeather.swift
//  Parallel
//
//  Created by Анна Гареева on 02.06.2020.
//  Copyright © 2020 Anna Gareeva. All rights reserved.
//

import UIKit


struct CurrentWeather {
    var cityName: String
    var temp: Double
    var conditionCode: Int
    var temp_min: Int
    
    var systemIconNameString: String {
        switch conditionCode {
        case 200...232: return "cloud.bold.rain.fill"
        case 300...321: return "cloud.drizzle.fill"
        case 500...531: return "cloud.rain.fill"
        case 600...622: return "cloud.snow.fill"
        case 701...781: return "smoke.fill"
        case 800: return "sun.min.fill"
        case 801...804: return "cloud.fill"
        default:
            return "nosign"
        }
    }
    
    var tempString: String {
        return String(format: "%.0f", temp)
    }
    
    init?(currentWeatherData: CurrentWeatherData) {
        cityName = currentWeatherData.name
        temp = currentWeatherData.main.temp
        conditionCode = currentWeatherData.weather.first!.id
        temp_min = Int(currentWeatherData.main.temp_min.rounded())
    }
    
}

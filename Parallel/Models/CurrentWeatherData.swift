//
//  JsonModel.swift
//  Parallel
//
//  Created by Анна Гареева on 02.06.2020.
//  Copyright © 2020 Anna Gareeva. All rights reserved.
//

import UIKit

struct CurrentWeatherData: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
}


struct Main : Decodable{
    let temp: Double
    let temp_min: Double
    
    enum CodingKeys: String, CodingKey {
        case temp, temp_min
    }
}

struct Weather : Decodable{
    let id: Int
}

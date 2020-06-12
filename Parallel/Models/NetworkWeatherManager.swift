//
//  NetworkWeatherManager.swift
//  Parallel
//
//  Created by Анна Гареева on 02.06.2020.
//  Copyright © 2020 Anna Gareeva. All rights reserved.
//

import UIKit
import  CoreLocation


class NetworkWeatherManager {
    
    enum RequestType {
        case cityName(city: String)
        case coordinate(Latitude: CLLocationDegrees, Longitude: CLLocationDegrees)
    }
    
    var completionHandler: ((CurrentWeather) -> Void)?
    
    func fetchCurrent(forRequestType requestType: RequestType) {
        var urlString = ""
        switch requestType {
        case .cityName(let city):
            urlString = "https://openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)&units=metric"
        case .coordinate(let forLatitude,let Longitude):
           urlString = "https://openweathermap.org/data/2.5/weather?lat=\(forLatitude)&lon=\(Longitude)&appid=\(apiKey)&units=metric"
        }
        performRequest(withUrlString: urlString)
    }
    
    fileprivate func performRequest(withUrlString urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let data = data {
                if  let currentWeather = self.parseJSON(withData: data) {
                    self.completionHandler?(currentWeather)
                }
            }
        }
        task.resume()
    }
    
    fileprivate func parseJSON(withData data: Data) -> CurrentWeather? {
        let decoder = JSONDecoder()
        do {
            let currentWeatherData = try decoder.decode(CurrentWeatherData.self, from: data)
            guard let currentWeather = CurrentWeather(currentWeatherData: currentWeatherData) else { return nil }
            return currentWeather
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
}

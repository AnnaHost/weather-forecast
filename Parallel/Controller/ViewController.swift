//
//  ViewController.swift
//  Parallel
//
//  Created by Анна Гареева on 02.06.2020.
//  Copyright © 2020 Anna Gareeva. All rights reserved.
//

import UIKit
import  CoreLocation

class ViewController: UIViewController {
    
    var networkManager = NetworkWeatherManager()
    
    lazy var locationManager: CLLocationManager = {
        let lm = CLLocationManager()
        lm.delegate = self
        lm.desiredAccuracy = kCLLocationAccuracyKilometer
        lm.requestWhenInUseAuthorization()
        return lm
    }()
    
    @IBOutlet weak var imageLabel: UIImageView!
    @IBOutlet weak var currentWeather: UILabel!
    @IBOutlet weak var feelsLike: UILabel!
    @IBOutlet weak var city: UILabel!
    
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        presentAlertController(withTitle: "Enter a city", message: nil, style: .alert) { [unowned self] city in
            self.networkManager.fetchCurrent(forRequestType: .cityName(city: city))
        }
        networkManager.completionHandler = {[weak self] currentWeather in
            self?.updateInterface(with: currentWeather)
        }
    }
    
    func updateInterface(with currentWeather: CurrentWeather){
        DispatchQueue.main.async {
            self.currentWeather.text = "\(currentWeather.tempString) ºC"
            self.city.text = currentWeather.cityName
            self.imageLabel.image = UIImage(systemName: currentWeather.systemIconNameString)
            self.feelsLike.text = "Min temperature: \(currentWeather.temp_min)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkManager.completionHandler = {[weak self] currentWeather in
            self?.updateInterface(with: currentWeather)
        }
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestLocation()
        }
    }
}


extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        networkManager.fetchCurrent(forRequestType: .coordinate(Latitude: latitude, Longitude: longitude))
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}

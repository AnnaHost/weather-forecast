//
//  ViewController+alertController.swift
//  Parallel
//
//  Created by Анна Гареева on 02.06.2020.
//  Copyright © 2020 Anna Gareeva. All rights reserved.
//

import UIKit


extension ViewController {
    
    func presentAlertController(withTitle title: String?, message:String?, style: UIAlertController.Style, complesionHandler: @escaping (String) -> Void) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: style)
        ac.addTextField { tf in
            let cities = ["Moscow", "Los Angeles", "Surgut", "Sankt Petersburg"]
            tf.placeholder = cities.randomElement()
        }
        let searchAction = UIAlertAction(title: "Search", style: .default) { _ in
            let tf = ac.textFields?.first
            guard let cityName = tf?.text else { return }
            if cityName != "" {
               // self.networkManager.fetchCurrentweather(forCity: cityName)
                let city = cityName.split(separator: " ").joined(separator: "%20")
                complesionHandler(city)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        ac.addAction(searchAction)
        ac.addAction(cancelAction)
        present(ac, animated: true)
    }
}

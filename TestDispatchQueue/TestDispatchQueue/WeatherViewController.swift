//
//  WeatherViewController.swift
//  TestDispatchQueue
//
//  Created by Kosuke Nishimura on 2019/06/01.
//  Copyright © 2019 Kosuke.Nishimura. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    static let id = "WeatherVC"
    
    @IBOutlet private weak var cityLabel: UILabel!
    @IBOutlet private weak var temperatureLabel: UILabel!
    
    var city: String = "city"
    var temperature: Float = 0
    
    var weatherData: WeatherData?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let weatherData = weatherData else {
            return
        }
        
        city = weatherData.city
        temperature = weatherData.airCondition.temperature
        
        changeLabelText()
    }
    
    func changeLabelText() {
        guard let weatherData = self.weatherData else {
            cityLabel.text = city
            temperatureLabel.text = "\(temperature)"
            return
        }
        cityLabel.text = weatherData.city
        temperatureLabel.text = "\(weatherData.airCondition.temperature) degree"
    }
    
    @IBAction func dismissButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}

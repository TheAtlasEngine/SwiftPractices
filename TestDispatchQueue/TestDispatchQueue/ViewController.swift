//
//  ViewController.swift
//  TestDispatchQueue
//
//  Created by Kosuke Nishimura on 2019/06/01.
//  Copyright © 2019 Kosuke.Nishimura. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let city = "tokyo"
    let country = "jp"
    let apiManager = ApiManager()
    
    lazy var weatherVC = storyboard!.instantiateViewController(withIdentifier: WeatherViewController.id) as! WeatherViewController
    
    let operationQueue = OperationQueue()

    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        activityIndicatorView.hidesWhenStopped = true
    }
    
    @IBAction func fetchWeatherDataButtonTapped(_ sender: Any) {
        self.activityIndicatorView.startAnimating()
        self.apiManager.callApi(city: self.city, country: self.country) { (result) in
            switch result {
            case .success(let weatherData):
                self.weatherVC.weatherData = weatherData
                DispatchQueue.main.async {
                    self.activityIndicatorView.stopAnimating()
                    self.present(self.weatherVC, animated: true, completion: nil)
                    self.weatherVC.changeLabelText()
                }
            case .failure(let error):
                self.activityIndicatorView.stopAnimating()
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}


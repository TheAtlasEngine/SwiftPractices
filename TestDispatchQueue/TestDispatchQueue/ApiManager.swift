//
//  ApiManager.swift
//  TestDispatchQueue
//
//  Created by Kosuke Nishimura on 2019/06/01.
//  Copyright © 2019 Kosuke.Nishimura. All rights reserved.
//

import Foundation

class ApiManager {
    
    let session = URLSession.shared
    
    var country: String = ""
    var temperature: Float = 0
    
    let apiKey = "2d0d4bcfd001f521e6fc19fbf85e3f67"
    let baseUrl = "https://api.openweathermap.org/data/2.5/weather?"
    
    func callApi(city: String, country: String?, completion: @escaping (Result<WeatherData, Error>) -> Void) {
        guard var urlComponents = URLComponents(string: baseUrl) else {
            preconditionFailure("urlComponents is nil")
        }
        
        var locationQuery = city
        if let country = country {
            locationQuery += ",\(country)"
        }
        
        urlComponents.queryItems = [
            URLQueryItem(name: "appid", value: apiKey),
            URLQueryItem(name: "q", value: locationQuery)
        ]
        
        guard let url = urlComponents.url else {
            preconditionFailure("url is nil")
        }
        
        let request = URLRequest(url: url)
        
        let _ = session.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            guard let data = data else {
                print("Error: data == nil")
                return
            }
            
            do {
                print(String(data: data, encoding: .utf8)!)
                let weatherData = try JSONDecoder().decode(WeatherData.self, from: data)
                completion(.success(weatherData))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
}

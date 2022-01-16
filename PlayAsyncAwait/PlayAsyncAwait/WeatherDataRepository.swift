//
//  WeatherDataRepository.swift
//  PlayAsyncAwait
//
//  Created by Kosuke Nishimura on 2022/01/16.
//

import Foundation

struct WeatherData: Decodable {
    let publishingOffice: String
    let reportDatetime: String
    let targetArea: String
    let headlineText: String
    let text: String
}

protocol WeatherDataRepository {
    func fetch() async throws -> WeatherData
}

class DefaultWeatherDataRepository: WeatherDataRepository {
    
    private let request = URLRequest(url: URL(string: "https://www.jma.go.jp/bosai/forecast/data/overview_forecast/130000.json")!)
    private let session = URLSession.shared
    
    private let decoder = JSONDecoder()
    
    func fetch() async throws -> WeatherData {
        let (data, response) = try await session.data(for: request, delegate: nil)
        
        if let response = response as? HTTPURLResponse {
            print("Status Code: " + response.statusCode.description)
        }
        
        return try decoder.decode(WeatherData.self, from: data)
    }
    
    // closure-based implementation
    func fetch(result: @escaping ((WeatherData?, Error?) -> Void)) {
        let task = session.dataTask(with: request) { [weak self] data, response, error in
            guard let self = self else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                let weatherData = try self.decoder.decode(WeatherData.self, from: data)
                result(weatherData, error)
            } catch {
                result(nil, error)
            }
        }
        
        task.resume()
    }
    
}

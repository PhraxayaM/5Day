//
//  WeatherNetworkManager.swift
//  5Day
//
//  Created by MattHew Phraxayavong on 4/15/20.
//  Copyright © 2020 MattHew Phraxayavong. All rights reserved.
//

import Foundation

class WeatherNetworkManager: NMProtocol {
    
    
    func getWeather(city: String, completion: @escaping (WeatherModel) -> ()) {
        
        let API_URL = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(NetworkProperties.API_KEY)"

        guard let url = URL(string: API_URL) else {
            fatalError()
        }
                     
        let urlRequest = URLRequest(url: url)
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
        guard let data = data else { return }

            do {
                let currentWeather = try JSONDecoder().decode(WeatherModel.self, from: data)
                completion(currentWeather)
            } catch {
                 print(error)
            }

        }.resume()
    }
}

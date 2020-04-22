//
//  NMProtocol.swift
//  5Day
//
//  Created by MattHew Phraxayavong on 4/15/20.
//  Copyright © 2020 MattHew Phraxayavong. All rights reserved.
//

import Foundation

protocol NMProtocol {
    func getWeather(city: String, completion: @escaping (WeatherModel) -> ())

    func getForecast(city: String, completion: @escaping ([ForecastTemperature]) -> ())
}

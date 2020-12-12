//
//  KelvinToCelsiusConverter.swift
//  5Day
//
//  Created by MattHew Phraxayavong on 4/20/20.
//  Copyright © 2020 MattHew Phraxayavong. All rights reserved.
//

import Foundation

extension Float {
    func truncate(places : Int)-> Float
    {
        return Float(floor(pow(10.0, Float(places)) * self)/pow(10.0, Float(places)))
    }
    
    func kelvinToCelsiusConverter() -> Float {
        let constantVal : Float = 273.15
        let kelValue = self
        let celValue = kelValue - constantVal
        return celValue.truncate(places: 1)
    }
    func kelvinToFahrenheitConverter() -> Float {
        let constantVal : Float = 273
        let kelValue = self
        print("kel", kelValue)
        let sum = (kelValue - constantVal)
        let celValue = sum + 32
        
        return celValue.truncate(places: 1)
    }
    func FahrenheitConverter() -> Float {
        let constantVal : Float = 273
        let kelValue = self
        print("kel", kelValue)
        let sum = 1.8 * kelValue
        let celValue = sum + 32
        print("celvalue", celValue)
        
        return celValue.truncate(places: 1)
    }
}

//
//  HomeViewConstraints.swift
//  5Day
//
//  Created by MattHew Phraxayavong on 4/16/20.
//  Copyright © 2020 MattHew Phraxayavong. All rights reserved.
//

import Foundation
extension ViewController {
    
    func setupConstraints() {
        currentLocation.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        currentLocation.heightAnchor.constraint(equalToConstant: 70).isActive = true
        currentLocation.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18).isActive = true
//        
//        currentTime.topAnchor.constraint(equalTo: currentLocation.bottomAnchor, constant: 4).isActive = true
//        currentTime.heightAnchor.constraint(equalToConstant: 10).isActive = true
//        currentTime.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18).isActive = true
//        
//        currentTemperatureLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20).isActive = true
//        
//        currentTemperatureLabel.heightAnchor.constraint(equalToConstant: 70).isActive = true
//        currentTemperatureLabel.widthAnchor.constraint(equalToConstant: 250).isActive = true
//        
//        tempSymbol.topAnchor.constraint(equalTo: currentTemperatureLabel.bottomAnchor).isActive = true
//        
//        tempSymbol.heightAnchor.constraint(equalToConstant: 50).isActive = true
//        tempSymbol.widthAnchor.constraint(equalToConstant: 50).isActive = true
//        
//        tempDescription.topAnchor.constraint(equalTo: currentTemperatureLabel.bottomAnchor, constant: 50).isActive = true
//        tempDescription.heightAnchor.constraint(equalToConstant: 20).isActive = true
//        tempDescription.widthAnchor.constraint(equalToConstant: 250).isActive = true
//        
//        minTemp.topAnchor.constraint(equalTo: tempSymbol.bottomAnchor, constant: 80).isActive = true
//        minTemp.heightAnchor.constraint(equalToConstant: 20).isActive = true
//        minTemp.widthAnchor.constraint(equalToConstant: 100).isActive = true
//        
//        maxTemp.topAnchor.constraint(equalTo: minTemp.bottomAnchor).isActive = true
//        maxTemp.heightAnchor.constraint(equalToConstant: 20).isActive = true
//        maxTemp.widthAnchor.constraint(equalToConstant: 100).isActive = true
//        
    }
}

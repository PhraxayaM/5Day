//
//  ViewController.swift
//  5Day
//
//  Created by MattHew Phraxayavong on 4/15/20.
//  Copyright © 2020 MattHew Phraxayavong. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    
    let networkManager = WeatherNetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        // Do any additional setup after loading the view.
        var city = "Sacramento"
        networkManager.getWeather(city: city) { (weather) in
            print("temp test", weather.main.temp)
            
            
        }
        
        setupView()
        var test = "Sacramento"
        loadData(city: test)

}
   
    func setupView() {
        view.addSubview(currentTemperatureLabel)
        view.addSubview(currentTime)
        view.addSubview(currentLocation)
        view.addSubview(tempDescription)
        view.addSubview(tempSymbol)
        view.addSubview(maxTemp)
        view.addSubview(minTemp)
        setupConstraints()
        
    }
    
    let currentLocation: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Location"
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 38, weight: .heavy)
        return label
    }()
    
    let currentTime: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "20 April 2020"
        label.textAlignment = .left
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 10, weight: .heavy)
        return label
    }()
    
    let currentTemperatureLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "°C"
        label.textColor = .label
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 60, weight: .heavy)
        return label
    }()
    
    let tempDescription: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "..."
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        return label
    }()
    let tempSymbol: UIImageView = {
       let img = UIImageView()
        img.image = UIImage(systemName: "cloud.fill")
        img.contentMode = .scaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false
        img.tintColor = .gray
        return img
    }()
    

    let maxTemp: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "  °C"
        label.textAlignment = .left
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    let minTemp: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "  °C"
        label.textAlignment = .left
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    var locationManager = CLLocationManager()
    var currentLoc: CLLocation?
    var stackView : UIStackView!
    var latitude : CLLocationDegrees!
    var longitude: CLLocationDegrees!
    
    func loadData(city: String) {
        networkManager.getWeather(city: city) { (weather) in
             print("Current Temperature")
             let formatter = DateFormatter()
             formatter.dateFormat = "dd MMM yyyy"
            let stringDate = formatter.string(from: Date(timeIntervalSince1970: TimeInterval(weather.dt)))
             
             DispatchQueue.main.async {
                 self.tempDescription.text = weather.weather[0].description
                self.currentLocation.text = "\(weather.name ?? "") , \(weather.sys.country ?? "")"

             }
         }
    }
}


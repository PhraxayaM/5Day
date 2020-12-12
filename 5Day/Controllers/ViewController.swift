//
//  ViewController.swift
//  5Day
//
//  Created by MattHew Phraxayavong on 4/15/20.
//  Copyright © 2020 MattHew Phraxayavong. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    
    let networkManager = WeatherNetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var city = "Sacramento"
        networkManager.getWeather(city: city) { (weather) in
            print("temp test", weather.main.temp, "hey: \(weather)")
            
            
        }
        
        setupView()
        setupPermissionRequest()
        networkManager.delegate = self
        setupViewstack()

}
   
    func setupView() {
//        view.addSubview(currentTemperatureLabel)
//        view.addSubview(currentTime)
        view.addSubview(currentLocation)
//        view.addSubview(tempDescription)
//        view.addSubview(tempSymbol)
//        view.addSubview(maxTemp)
//        view.addSubview(minTemp)
        setupConstraints()
        setupNavbar()
        
        var firstC = UIColor.rgb(red: 74, green: 115, blue: 184)
         var secondC = UIColor.rgb(red: 120, green: 15, blue: 134)
        view.addGradientBackground(firstColor: firstC, secondColor: secondC)
    }
    func setupViewstack() {
        
        let stackView = UIStackView(arrangedSubviews: [ currentTemperatureLabel, currentTime, tempDescription, tempSymbol, minTemp, maxTemp])
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        stackView.spacing = 30
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        currentTemperatureLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        stackView.anchor(top: currentLocation.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 90, paddingLeft: 40, paddingBottom: 20, paddingRight: 40, width: 0, height: 400)
        
    }
    func setupPermissionRequest(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.requestLocation()
    }
    func setupNavbar() {
        self.navigationItem.rightBarButtonItems = [UIBarButtonItem(image: UIImage(systemName: "plus.circle"), style: .done, target: self, action: #selector(updateLocationButton)),
        UIBarButtonItem(image: UIImage(systemName: "book"), style: .done, target: self, action: #selector(pushForecastVC))]
    }
    
    let currentLocation: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Location"
        label.textAlignment = .left
        label.numberOfLines = 3
        label.font = UIFont.systemFont(ofSize: 40, weight: .heavy)
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
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 60, weight: .heavy)
        return label
    }()
    
    let tempDescription: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "..."
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
            print("Current Temperature", weather.main.temp.kelvinToCelsiusConverter())
             let formatter = DateFormatter()
             formatter.dateFormat = "dd MMM yyyy"
            let stringDate = formatter.string(from: Date(timeIntervalSince1970: TimeInterval(weather.dt)))
             
             DispatchQueue.main.async {
                 self.tempDescription.text = weather.weather[0].description
                self.currentLocation.text = "\(weather.name ?? "") , \(weather.sys.country ?? "")"
                self.currentTemperatureLabel.text = (String(weather.main.temp.kelvinToFahrenheitConverter()) + "°")
                self.minTemp.text = ("Min: " + String(weather.main.temp_min.kelvinToFahrenheitConverter()) + "°" )
                self.maxTemp.text = ("Max: " + String(weather.main.temp_max.kelvinToFahrenheitConverter()) + "°" )
                UserDefaults.standard.set("\(weather.name ?? "")", forKey: "SelectedCity")

             }
         }
    }
    
    //  Allows the updateLocation function to call on the loadData function after saving
    
    @objc func updateLocationButton() {
        let alertController = UIAlertController(title: "Update City", message: "", preferredStyle: .alert)
         alertController.addTextField { (textField : UITextField!) -> Void in
             textField.placeholder = "Name of City"
         }
         let save = UIAlertAction(title: "Add", style: .default, handler: { alert -> Void in
             let firstTextField = alertController.textFields![0] as UITextField
             print("City Name: \(firstTextField.text)")
            guard let cityName = firstTextField.text else { return }
            self.loadData(city: cityName) // Calling the loadData function
         })
         let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: { (action : UIAlertAction!) -> Void in
            print("Cancel")
         })


         alertController.addAction(save)
         alertController.addAction(cancel)

         self.present(alertController, animated: true, completion: nil)
    }
    @objc func pushForecastVC() {
        self.navigationController?.pushViewController(ForecastVC(), animated: true)
    }
}

extension ViewController: CLLocationManagerDelegate, WeatherManagerDel {
    func updateWeather(weather: WeatherModel) {
        print("weather name: weather.name")
        DispatchQueue.main.async {
            self.currentLocation.text = weather.name
            self.currentTemperatureLabel.text = (String(weather.main.temp.FahrenheitConverter()) + "°")
            self.minTemp.text = ("Min: " + String(weather.main.temp_min.FahrenheitConverter()) + "°" )
            self.maxTemp.text = ("Max: " + String(weather.main.temp_max.FahrenheitConverter()) + "°" )
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("got location data")
        
        if let location = locations.last {
            let lat = location.coordinate.latitude
            let long = location.coordinate.longitude
            print(lat, long)
            networkManager.getLocation(lat: lat, lon: long) { (weather) in
                print(weather)
            }
            }
        
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

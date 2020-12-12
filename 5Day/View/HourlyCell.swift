//
//  HourlyCell.swift
//  5Day
//
//  Created by MattHew Phraxayavong on 4/20/20.
//  Copyright © 2020 MattHew Phraxayavong. All rights reserved.
//

import Foundation
import UIKit
class HourlyCell: UICollectionViewCell {
    
    static var reuseIdentifier: String = "HourlyCell"
    
    let hourlyTimeLabel: UILabel = {
       let label = UILabel()
        label.text = "05:00"
        label.font = UIFont.systemFont(ofSize: 8)
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let tempSymbol: UIImageView = {
       let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let tempLabel: UILabel = {
       let label = UILabel()
        label.text = "05:00"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(frame: CGRect) {
         super.init(frame: frame)
//        contentView.backgroundColor = UIColor.systemBackground
         contentView.layer.cornerRadius = 10
         contentView.layer.masksToBounds = true
    
        
         setupViews()
         layoutViews()
     }
    var collectionView : UICollectionView!
    func setupViews() {
        addSubview(hourlyTimeLabel)
        addSubview(tempSymbol)
        addSubview(tempLabel)
//        var firstC = UIColor.rgb(red: 168, green: 159, blue: 148)
//         var secondC = UIColor.rgb(red: 113, green: 102, blue: 237)
//        addGradientBackground(firstColor: firstC, secondColor: secondC)
    }
    
    private func addBackgroundGradient(firstColor: UIColor, secondColor: UIColor) {
        let collectionViewBackgroundView = UIView()
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame.size = frame.size
        // Start and end for left to right gradient
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        gradientLayer.colors = [firstColor.cgColor, secondColor.cgColor]
        collectionView.backgroundView = collectionViewBackgroundView
        collectionView.backgroundView?.layer.addSublayer(gradientLayer)
      }
    
    func layoutViews() {
        hourlyTimeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 4).isActive = true
        hourlyTimeLabel.heightAnchor.constraint(equalToConstant: 10).isActive = true
        hourlyTimeLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        hourlyTimeLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        tempSymbol.topAnchor.constraint(equalTo: hourlyTimeLabel.bottomAnchor, constant: 6).isActive = true
        tempSymbol.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        tempSymbol.heightAnchor.constraint(equalToConstant: 30).isActive = true
        tempSymbol.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        tempLabel.topAnchor.constraint(equalTo: tempSymbol.bottomAnchor).isActive = true
        tempLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        tempLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        tempLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with item: WeatherInfo) {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"

        if let date = dateFormatterGet.date(from: item.time) {
            hourlyTimeLabel.text = dateFormatter.string(from: date)
        }
        tempSymbol.loadImageFromURL(url: "http://openweathermap.org/img/wn/\(item.icon)@2x.png")
        tempLabel.text = String(item.temp.kelvinToFahrenheitConverter()) + " °C"
    }
}


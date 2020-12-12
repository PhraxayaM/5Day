//
//  ForecastCell.swift
//  5Day
//
//  Created by MattHew Phraxayavong on 4/20/20.
//  Copyright © 2020 MattHew Phraxayavong. All rights reserved.
//

import Foundation
import UIKit

class ForecastCell: UICollectionViewCell, CellSelfConstruct, UICollectionViewDelegate, UICollectionViewDataSource {
    static var reuseIdentifier: String = "ForecastCell"
    
    let weekdaylabel: UILabel = {
       let label = UILabel()
        label.text = "Monday"
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
    
    
    var dailyForecast: [WeatherInfo] = []
    var collectionView : UICollectionView!

    override init(frame: CGRect) {
         super.init(frame: frame)
//        contentView.backgroundColor = .white
        
        
         contentView.layer.cornerRadius = 10
         contentView.layer.masksToBounds = true
        
        collectionView = UICollectionView(frame: CGRect(x: 100, y: 0, width: (frame.width - 112), height: frame.height), collectionViewLayout: createCompositionalLayout())
        collectionView.register(HourlyCell.self, forCellWithReuseIdentifier: HourlyCell.reuseIdentifier)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        collectionView.backgroundColor = #colorLiteral(red: 0.9443109632, green: 1, blue: 0.9847763181, alpha: 1)
        collectionView.backgroundView = nil
        collectionView.backgroundColor = UIColor.clear
        collectionView.delegate = self
        collectionView.dataSource = self
        addSubview(collectionView)
         setupViews()
         layoutViews()
     }
    
    func setupViews() {
        addSubview(weekdaylabel)
        addSubview(tempSymbol)
//        var firstC = UIColor.rgb(red: 74, green: 115, blue: 184)
//         var secondC = UIColor.rgb(red: 120, green: 15, blue: 134)
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
        weekdaylabel.topAnchor.constraint(equalTo: topAnchor, constant: 12).isActive = true
        weekdaylabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        weekdaylabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        weekdaylabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            self.createFeaturedSection()
        }

        let config = UICollectionViewCompositionalLayoutConfiguration()
        layout.configuration = config
        return layout
    }
        
    func createFeaturedSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/4), heightDimension: .fractionalHeight(0.75))

       let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
       layoutItem.contentInsets = NSDirectionalEdgeInsets(top:5, leading: 5, bottom: 0, trailing: 5)

       let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(110))
       let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])

       let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
       layoutSection.orthogonalScrollingBehavior = .groupPagingCentered



       return layoutSection
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dailyForecast.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyCell.reuseIdentifier, for: indexPath) as! HourlyCell
        cell.configure(with: dailyForecast[indexPath.row])
        return cell
    }
    
    func configure(with item: ForecastTemperature) {
        weekdaylabel.text = item.weekDay
        dailyForecast = item.hourlyForecast ?? []
    }

}

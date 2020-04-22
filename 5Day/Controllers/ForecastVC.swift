//
//  ForecastVC.swift
//  5Day
//
//  Created by MattHew Phraxayavong on 4/20/20.
//  Copyright © 2020 MattHew Phraxayavong. All rights reserved.
//

import UIKit

class ForecastVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    var forecastData: [ForecastTemperature] = []
    var collectionView : UICollectionView!
    var networkManager = WeatherNetworkManager()

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.view.backgroundColor = .blue


        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.register(ForecastCell.self, forCellWithReuseIdentifier: ForecastCell.reuseIdentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
//        collectionView.backgroundColor = .purple

        // Do any additional setup after loading the view.
        setupViews()
        
//        let city = UserDefaults.standard.string(forKey: "SelectedCity") ?? ""
//        print("City Forecast:", city)
        let city = "Sacramento"
        print("City Forecast:", city)
        networkManager.getForecast(city: city) { (forecast) in
            self.forecastData = forecast
            print("Total Count:", forecast.count)
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        forecastData = []
    }
    
    func setupViews() {
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return forecastData.count
//        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ForecastCell.reuseIdentifier, for: indexPath) as! ForecastCell
        cell.configure(with: forecastData[indexPath.row])
        cell.backgroundColor = .red
        return cell
    }
    
    

    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            self.createSection()
        }

        let config = UICollectionViewCompositionalLayoutConfiguration()
        layout.configuration = config
        return layout
    }
    
    func createSection() -> NSCollectionLayoutSection {
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))

           let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
           layoutItem.contentInsets = NSDirectionalEdgeInsets(top:5, leading: 5, bottom: 0, trailing: 5)

           let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(110))
           let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize, subitems: [layoutItem])

           let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
           return layoutSection
    }

}

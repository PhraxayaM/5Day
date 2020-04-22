//
//  CellSelfConstruct.swift
//  5Day
//
//  Created by MattHew Phraxayavong on 4/20/20.
//  Copyright © 2020 MattHew Phraxayavong. All rights reserved.
//

import Foundation
protocol CellSelfConstruct {
    static var reuseIdentifier: String { get }
    func configure(with item: ForecastTemperature)
}

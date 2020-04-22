//
//  IntIncrementDays.swift
//  5Day
//
//  Created by MattHew Phraxayavong on 4/21/20.
//  Copyright © 2020 MattHew Phraxayavong. All rights reserved.
//

import Foundation

extension Int {
    func incrementWeekDays(by num: Int) -> Int {
        let incrementedVal = self + num
        let mod = incrementedVal % 7
        
        return mod
    }
}
extension Date {
    func dayOfWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "XXXX"
        return dateFormatter.string(from: self).capitalized
    }
}

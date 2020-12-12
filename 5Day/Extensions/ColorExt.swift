//
//  ColorExt.swift
//  5Day
//
//  Created by MattHew Phraxayavong on 12/10/20.
//  Copyright © 2020 MattHew Phraxayavong. All rights reserved.
//


import UIKit

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

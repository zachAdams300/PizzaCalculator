//
//  TimeIntervalExtensions.swift
//  PizzaCalculator
//
//  Created by Zachary Adams on 2/23/24.
//

import Foundation

extension TimeInterval {
    static func minutes(_ minutes: Int) -> TimeInterval {
        return Double(minutes * 60)
    }
}

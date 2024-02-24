//
//  PizzaLiveTimerAttributes.swift
//  PizzaCalculator
//
//  Created by Zachary Adams on 2/23/24.
//

#if canImport(ActivityKit)

import ActivityKit

struct PizzaLiveTimerAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
//        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var timeLeft: Double
}

#endif

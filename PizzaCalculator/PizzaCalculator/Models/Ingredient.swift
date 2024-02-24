//
//  Ingredient.swift
//  PizzaCalculator
//
//  Created by Zachary Adams on 2/23/24.
//

import Foundation

struct Ingredient: Identifiable {
    let id = UUID()
    var name: String
    var amount: Double
    var units: String
}

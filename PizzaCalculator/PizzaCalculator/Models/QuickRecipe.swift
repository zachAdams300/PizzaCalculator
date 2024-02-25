//
//  QuickRecipe.swift
//  PizzaCalculator
//
//  Created by Zachary Adams on 1/28/24.
//

import Foundation

struct QuickRecipe: Recipe {
    var numPizzas: Int
    
    static let instructions: [Instruction] = [
        
    ]
    
    var ingredients: [Ingredient] { [
       Ingredient(name: "Water", amount: Double(160 * numPizzas), units: "g"),
       Ingredient(name: "Yeast", amount: 3.5 * Double(numPizzas), units: "g"),
       Ingredient(name: "Sugar", amount: 7.5 * Double(numPizzas), units: "g"),
       Ingredient(name: "Olive Oil", amount: Double(15 * numPizzas), units: "g"),
       Ingredient(name: "Bread Flour", amount: Double(225 * numPizzas), units: "g"),
       Ingredient(name: "Salt", amount: Double(numPizzas), units: "teaspoons"),
       ]
   }
}

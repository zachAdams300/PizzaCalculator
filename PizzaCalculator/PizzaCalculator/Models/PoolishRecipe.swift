//
//  PoolishRecipe.swift
//  PizzaCalculator
//
//  Created by Zachary Adams on 1/28/24.
//

import Foundation

struct PoolishRecipe: Recipe {
    static let instructions: [Instruction] = [
        Instruction(stepDescription: "Combine water for poolish, yeast, and honey.", timeNeeded: 0, showsCountdown: false),
        Instruction(stepDescription: "Add 00 flour for poolish and stir to combine.", timeNeeded: 0, showsCountdown: false),
        Instruction(stepDescription: "Allow to sit at room temperature for 15 minutes without the lid.", timeNeeded: TimeInterval.minutes(15), showsCountdown: true),
        Instruction(stepDescription: "Put the lid on and allow to sit at room temperature for another hour.", timeNeeded: TimeInterval.minutes(60), showsCountdown: true),
        Instruction(stepDescription: "Refrigerate for 16-24 hours.", timeNeeded: TimeInterval.minutes(0), showsCountdown: false),
        Instruction(stepDescription: "Remove from fridge and allow to warm up at room temperature for 1 hour.", timeNeeded: TimeInterval.minutes(60), showsCountdown: true),
        Instruction(stepDescription: "In a very large bowl combine both flours for the dough and the poolish.", timeNeeded: 0, showsCountdown: false),
        Instruction(stepDescription: "In a seperate container, combine water for dough and salt and stir to combine.", timeNeeded: 0, showsCountdown: false),
        Instruction(stepDescription: "Combine the water solution with the dry ingredients and keep kneeding the dough until the water is fully incorporated.", timeNeeded: 0, showsCountdown: false),
        Instruction(stepDescription: "Pat with olive oil and allow to sit on the counter for 15 minutes.", timeNeeded: TimeInterval.minutes(15), showsCountdown: true),
        Instruction(stepDescription: "Slap and fold. Then pat with olive oil and allow to sit for another 15 minutes.", timeNeeded: TimeInterval.minutes(15), showsCountdown: true),
        Instruction(stepDescription: "Round the dough off making sure there are no seams, pat with olive oil and cover with a damp towel. Let sit for 1 hour.", timeNeeded: TimeInterval.minutes(60), showsCountdown: true),
        Instruction(stepDescription: "Divide into preffered amount of dough balls, pat with olive oil, then cover and allow to sit for another hour. In the meantime, preheat oven to 550°F.", timeNeeded: TimeInterval.minutes(60), showsCountdown: true),
        Instruction(stepDescription: "Bake for 5 minutes, rotating the pizza halfway through.", timeNeeded: TimeInterval.minutes(5), showsCountdown: true),
    ]
    
     var ingredients: [Ingredient] {
         [
        Ingredient(name: "Water for poolish", amount: Double(67 * numPizzas), units: "g"),
        Ingredient(name: "00 flour for poolish", amount: Double(67 * numPizzas), units: "g"),
        Ingredient(name: "Honey", amount: 5, units: "g"),
        Ingredient(name: "Yeast", amount: 5, units: "g"),
        Ingredient(name: "Water for dough", amount: Double(100 * numPizzas), units: "g"),
        Ingredient(name: "00 flour for dough", amount: Double(67 * numPizzas), units: "g"),
        Ingredient(name: "Manitoba flour", amount: Double(100 * numPizzas), units: "g"),
        Ingredient(name: "Salt", amount: 6.7 * Double(numPizzas), units: "g"),
        ]
    }
    
    var numPizzas: Int
}

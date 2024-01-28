//
//  QuickRecipe.swift
//  PizzaCalculator
//
//  Created by Zachary Adams on 1/28/24.
//

import Foundation

struct QuickRecipe {
    let numPizzas: Int
    
    var waterGrams: Double {
        return Double(numPizzas) * 160
    }
    
    var yeastGrams: Double {
        return Double(numPizzas) * 3.5
    }
    
    var sugarGrams: Double {
        return Double(numPizzas) * 7.5
    }
    
    var oliveOilGrams: Double {
        return Double(numPizzas) * 15
    }
    
    var flourGrams: Double {
        return Double(numPizzas) * 225
    }
    
    var saltTeaspoons: Int {
        return numPizzas
    }
}

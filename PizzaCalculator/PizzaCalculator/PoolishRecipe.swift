//
//  PoolishRecipe.swift
//  PizzaCalculator
//
//  Created by Zachary Adams on 1/28/24.
//

import Foundation

struct PoolishRecipe {
    let numPizzas: Int
    
    //Poolish Part
    
    var poolishWaterGrams: Double {
        return Double(numPizzas) * 67
    }
    
    var poolish00FlourGrams: Double {
        return Double(numPizzas) * 67
    }
    
    var poolishHoneyGrams: Double {
        return 5
    }
    
    var poolishYeastGrams: Double {
        return 5
    }
    
    //Dough Part
    
    var doughWaterGrams: Double {
        return Double(numPizzas) * 100
    }
    
    var doughManitobaFlourGrams: Double {
        return Double(numPizzas) * 100
    }
    
    var dough00FlourGrams: Double {
        return Double(numPizzas) * 67
    }
    
    var doughSaltGrams: Double {
        return Double(numPizzas) * 6.7
    }
}

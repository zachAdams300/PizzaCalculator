//
//  UserDefaultsManager.swift
//  PizzaCalculator
//
//  Created by Zachary Adams on 2/23/24.
//

import Foundation

class UserDefaultsManager {
    static let makingPizzKey = "MakingPizza"
    static let currentStepKey = "CurrentStep"
    static let numPizzasKey = "NumPizzas"
    
    static func setIsMakingPizza(_ makingPizza: Bool) {
        UserDefaults.standard.setValue(makingPizza, forKey: makingPizzKey)
    }
    
    static func getIsMakingPizza() -> Bool {
        UserDefaults.standard.bool(forKey: makingPizzKey)
    }
    
    static func setCurrentStep(_ step: Int) {
        UserDefaults.standard.setValue(step, forKey: currentStepKey)
    }
    
    static func getCurrentStep() -> Int {
        UserDefaults.standard.integer(forKey: currentStepKey)
    }
    
    static func setNumPizzas(_ numPizzas: Int) {
        UserDefaults.standard.setValue(numPizzas, forKey: numPizzasKey)
    }
    
    static func getNumPizzas() -> Int {
        UserDefaults.standard.integer(forKey: numPizzasKey)
    }
}

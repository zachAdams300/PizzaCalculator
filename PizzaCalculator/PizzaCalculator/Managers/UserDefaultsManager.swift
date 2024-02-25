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
    
    static func setIsMakingPizza(_ makingPizza: Bool, userDefaults: UserDefaults = UserDefaults.standard) {
        userDefaults.setValue(makingPizza, forKey: makingPizzKey)
    }
    
    static func getIsMakingPizza(userDefaults: UserDefaults = UserDefaults.standard) -> Bool {
        userDefaults.bool(forKey: makingPizzKey)
    }
    
    static func setCurrentStep(_ step: Int, userDefaults: UserDefaults = UserDefaults.standard) {
        userDefaults.setValue(step, forKey: currentStepKey)
    }
    
    static func getCurrentStep(userDefaults: UserDefaults = UserDefaults.standard) -> Int {
        userDefaults.integer(forKey: currentStepKey)
    }
    
    static func setNumPizzas(_ numPizzas: Int, userDefaults: UserDefaults = UserDefaults.standard) {
        userDefaults.setValue(numPizzas, forKey: numPizzasKey)
    }
    
    static func getNumPizzas(userDefaults: UserDefaults = UserDefaults.standard) -> Int {
        userDefaults.integer(forKey: numPizzasKey)
    }
}

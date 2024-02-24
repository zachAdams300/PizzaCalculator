//
//  Recipe.swift
//  PizzaCalculator
//
//  Created by Zachary Adams on 2/23/24.
//

import Foundation

protocol Recipe {
    static var instructions: [Instruction] { get }
}

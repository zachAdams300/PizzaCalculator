//
//  ContentView.swift
//  PizzaCalculator
//
//  Created by Zachary Adams on 1/28/24.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    enum PizzaType: String, CaseIterable {
        case poolish = "Poolish"
        case quick = "Quick"
    }
    
    @StateObject private var viewModel = ContentViewViewModel()
    @State private var ingredientListExpanded = false
    @State private var type = PizzaType.poolish
    @State private var numberOfPizzas = 1
    @State private var poolishRecipe = PoolishRecipe(numPizzas: 1)
    @State private var quickRecipe = QuickRecipe(numPizzas: 1)
    
    @AppStorage(UserDefaultsManager.makingPizzKey) var isMakingPizza: Bool = false
    @AppStorage(UserDefaultsManager.currentStepKey) var currentStep: Int = 0

    
    var body: some View {
        NavigationStack {
            VStack {
                List() {
                    Section("Dough Type") {
                        Picker("Dough Type", selection: $type) {
                            ForEach(PizzaType.allCases, id:\.self) {type in
                                Text(type.rawValue)
                            }
                        }
                        
                        Stepper("Number of Pizzas: \(numberOfPizzas)", value: $numberOfPizzas, in: 1...10)
                            .onChange(of: numberOfPizzas) { oldValue, newValue in
                                poolishRecipe = PoolishRecipe(numPizzas: numberOfPizzas)
                                quickRecipe = QuickRecipe(numPizzas: numberOfPizzas)
                            }
                    }
                    .disabled(isMakingPizza)
                    
                    if type == .poolish {
                        Section ("Ingredients", isExpanded: $ingredientListExpanded) {
                            ForEach(poolishRecipe.ingredients, id:\.name) { ingredient in
                                TextRow(title: ingredient.name, value: "\(ingredient.amount)\(ingredient.units)")
                            }
                        }
//                        Section("Poolish", isExpanded: $ingredientListExpanded) {
//                            TextRow(title: "Grams of Water", value: "\(poolishRecipe.poolishWaterGrams)g")
//                            TextRow(title: "Grams of 00 Flour", value: "\(poolishRecipe.poolish00FlourGrams)g")
//                            TextRow(title: "Grams of Honey", value: "\(poolishRecipe.poolishHoneyGrams)g")
//                            TextRow(title: "Grams of Yeast", value: "\(poolishRecipe.poolishYeastGrams)g")
//                        }
//                        
//                        Section("Dough", isExpanded: $ingredientListExpanded) {
//                            TextRow(title: "Grams of Water", value: "\(poolishRecipe.doughWaterGrams)g")
//                            TextRow(title: "Grams of 00 Flour", value: "\(poolishRecipe.dough00FlourGrams)g")
//                            TextRow(title: "Grams of Manitoba Flour", value: "\(poolishRecipe.doughManitobaFlourGrams)g")
//                            TextRow(title: "Grams of Salt", value: "\(poolishRecipe.doughSaltGrams)g")
//                        }
                    }else {
                        Section("Dough", isExpanded: $ingredientListExpanded) {
                            TextRow(title: "Grams of Water", value: "\(quickRecipe.waterGrams)g")
                            
                            TextRow(title: "Grams of Sugar", value: "\(quickRecipe.sugarGrams)g")
                            TextRow(title: "Grams of Yeast", value: "\(quickRecipe.yeastGrams)g")
                            TextRow(title: "Grams of Flour", value: "\(quickRecipe.flourGrams)g")
                            TextRow(title: "Grams of Olive Oil", value: "\(quickRecipe.oliveOilGrams)g")
                            TextRow(title: "Teaspoons of Salt", value: "\(quickRecipe.saltTeaspoons)g")
                        }
                    }
                    
                    Button("Make the Pizza!") {
//                        NotificationManager.scheduleNotification(title: "Test Titlte", message: "Message", timeInterval: 5)
                        
                        viewModel.startBakingPizza()
//                        viewModel.startPizzaButtonTapped(timeLeft: 10)
                    }
                    
                    if isMakingPizza {
                        Section("Instructions") {
                            Text(PoolishRecipe.instructions[currentStep].stepDescription)
                            if PoolishRecipe.instructions[currentStep].showsCountdown {
                                Button("Set Timer") {
                                    viewModel.startPizzaButtonTapped(timeLeft: PoolishRecipe.instructions[currentStep].timeNeeded)
                                }
                            }
                            Button("Next") {
                                viewModel.showNextStep()
                            }
                        }
                    }
                }
                .listStyle(.sidebar)
                .navigationTitle("Pizza Calculator")
            }
            .toolbar {
                if isMakingPizza {
                    Button("Cancel") {
                        viewModel.cancelBakingPizza()
                    }
                }
            }
        }
        .onAppear() {
            NotificationManager.requestPermission { error in
                print(error.localizedDescription)
            }
        }
    }
}

#Preview {
    ContentView()
}

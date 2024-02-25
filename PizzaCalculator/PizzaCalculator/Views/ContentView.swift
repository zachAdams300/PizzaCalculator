//
//  ContentView.swift
//  PizzaCalculator
//
//  Created by Zachary Adams on 1/28/24.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    
    
    @StateObject private var viewModel = ContentViewViewModel()
    @State private var ingredientListExpanded = false
    @State private var type = PizzaType.poolish
    
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
                        
                        Stepper("Number of Pizzas: \(viewModel.numberOfPizzas)", value: $viewModel.numberOfPizzas, in: 1...10)
                            .onChange(of: viewModel.numberOfPizzas) { oldValue, newValue in
                                viewModel.changeNumPizzas(newValue)
                            }
                    }
                    .disabled(isMakingPizza)
                    
                    Section ("Ingredients", isExpanded: $ingredientListExpanded) {
                        if type == .poolish {
                            ForEach(viewModel.poolishRecipe.ingredients, id:\.name) { ingredient in
                                TextRow(title: ingredient.name, value: "\(ingredient.amount)\(ingredient.units)")
                            }
                        }else {
                            ForEach(viewModel.quickRecipe.ingredients, id:\.name) { ingredient in
                                TextRow(title: ingredient.name, value: "\(ingredient.amount)\(ingredient.units)")
                            }
                        }
                    }
                    
                    if !isMakingPizza {
                        Button("Make the Pizza!") {
                            viewModel.startBakingPizza()
                        }
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

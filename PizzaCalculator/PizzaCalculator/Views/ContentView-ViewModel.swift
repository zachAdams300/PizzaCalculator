//
//  ContentView-ViewModel.swift
//  PizzaCalculator
//
//  Created by Zachary Adams on 2/23/24.
//

import Foundation
import ActivityKit
import OSLog

enum PizzaType: String, CaseIterable {
    case poolish = "Poolish"
    case quick = "Quick"
}

@MainActor
final class ContentViewViewModel: ObservableObject {
    
    struct ActivityViewState: Sendable {
        var activityState: ActivityState
        var pushToken: String? = nil
        
        var shouldShowEndControls: Bool {
            switch activityState {
            case .active, .stale:
                return true
            case .ended, .dismissed:
                return false
            default:
                return false
            }
        }
        
        var isStale: Bool {
            return activityState == .stale
        }
    }
    
    @Published var activityViewState: ActivityViewState? = nil
    @Published var errorMessage: String? = nil
    
    @Published var numberOfPizzas: Int
    @Published var poolishRecipe: PoolishRecipe
    @Published var quickRecipe: QuickRecipe
    
    private var currentActivity: Activity<PizzaLiveTimerAttributes>? = nil
    
    init() {
        let savedNumPizzas = UserDefaultsManager.getNumPizzas()
        let numPizzas = savedNumPizzas > 0 ? savedNumPizzas : 1
        
        numberOfPizzas = numPizzas
        poolishRecipe = PoolishRecipe(numPizzas: numPizzas)
        quickRecipe = QuickRecipe(numPizzas: numPizzas)
    }
    
    func changeNumPizzas(_ newNumPizzas: Int) {
        poolishRecipe = PoolishRecipe(numPizzas: newNumPizzas)
        quickRecipe = QuickRecipe(numPizzas: newNumPizzas)
    }
    
    func startBakingPizza() {
        UserDefaultsManager.setIsMakingPizza(true)
        UserDefaultsManager.setCurrentStep(0)
    }
    
    func cancelBakingPizza() {
        UserDefaultsManager.setIsMakingPizza(false)
        UserDefaultsManager.setCurrentStep(0)
        NotificationManager.cancelNotifications()
        
        Task {
            await endActivity()
        } 
    }
    
    func showNextStep() {
        let currentStep = UserDefaultsManager.getCurrentStep()
        UserDefaultsManager.setCurrentStep(currentStep + 1)
    }
    
    func startPizzaButtonTapped(timeLeft: Double) {
        if ActivityAuthorizationInfo().areActivitiesEnabled {
            do {
                let pizzaTimer = PizzaLiveTimerAttributes(timeLeft: timeLeft)
                let initialState = PizzaLiveTimerAttributes.ContentState()
                
                let activity = try Activity.request(
                    attributes: pizzaTimer,
                    content: .init(state: initialState, staleDate: nil),
                    pushType: .token)
                
                self.setup(withActivity: activity)
            }catch {
                errorMessage = """
                    Couldn't start Activity
                    -------------------------
                    \(String(describing: error))
                """
                self.errorMessage = errorMessage
            }
        }
    }
}

private extension ContentViewViewModel {
    
    private func endActivity() async {
        guard let activity = currentActivity else {
            return
        }
        
        let finalContent = PizzaLiveTimerAttributes.ContentState()
        
        let dismissalPolicy: ActivityUIDismissalPolicy = .immediate
        
        await activity.end(ActivityContent(state: finalContent, staleDate: nil), dismissalPolicy: dismissalPolicy)
    }
    
    func setup(withActivity activity: Activity<PizzaLiveTimerAttributes>) {
        self.currentActivity = activity
        
        self.activityViewState = .init(
            activityState: activity.activityState,
            pushToken: activity.pushToken?.hexadecimalString)
        
        observeActivity(activity: activity)
    }
    
    func observeActivity(activity: Activity<PizzaLiveTimerAttributes>) {
        Task {
            await withTaskGroup(of: Void.self) { group in
                group.addTask { @MainActor in
                    for await activityState in activity.activityStateUpdates {
                        if activityState == .dismissed {
                            self.cleanUpDismissedActivity()
                        }else {
                            self.activityViewState?.activityState = activityState
                        }
                    }
                }
                
//                group.addTask { @MainActor in
//                    for await pushToken in activity.pushTokenUpdates {
//                        let pushTokenString = pushToken.hexadecimalString
//                        
//                        Logger().debug("New push token: \(pushTokenString)")
//                        
//                        do {
//                            let frequentUpdateEnabled = ActivityAuthorizationInfo().frequentPushesEnabled
//                            
//                            try await self.sendpush
//                        }
//                    }
//                    
//                }
            }
        }
    }
    
    func cleanUpDismissedActivity() {
        self.currentActivity = nil
        self.activityViewState = nil
    }
}

private extension Data {
    var hexadecimalString: String {
        self.reduce("") {
            $0 + String(format: "%02x", $1)
        }
    }
}

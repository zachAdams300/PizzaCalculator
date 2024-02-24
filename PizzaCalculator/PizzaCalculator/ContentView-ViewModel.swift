//
//  ContentView-ViewModel.swift
//  PizzaCalculator
//
//  Created by Zachary Adams on 2/23/24.
//

import Foundation
import ActivityKit
import OSLog

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
    
    private var currentActivity: Activity<PizzaLiveTimerAttributes>? = nil
    
    func startBakingPizza() {
        UserDefaultsManager.setIsMakingPizza(true)
        UserDefaultsManager.setCurrentStep(step: 0)
    }
    
    func cancelBakingPizza() {
        UserDefaultsManager.setIsMakingPizza(false)
        UserDefaultsManager.setCurrentStep(step: 0)
    }
    
    func showNextStep() {
        let currentStep = UserDefaultsManager.getCurrentStep()
        UserDefaultsManager.setCurrentStep(step: currentStep + 1)
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

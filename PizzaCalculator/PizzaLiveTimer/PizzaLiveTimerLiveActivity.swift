//
//  PizzaLiveTimerLiveActivity.swift
//  PizzaLiveTimer
//
//  Created by Zachary Adams on 2/23/24.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct PizzaLiveTimerLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: PizzaLiveTimerAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                HStack {
                    Spacer()
                    Text("Time Remaining: ")
                    Spacer()
                    Label {
                        Text(timerInterval: Date.now...Date(timeIntervalSinceNow: context.attributes.timeLeft), countsDown: true)
                            .monospacedDigit()
                    } icon: {
                        Image(systemName: "timer")
                            .foregroundColor(.indigo)
                    }
                    .font(.title2)
                }
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Time Remaining")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text(timerInterval: Date.now...Date(timeIntervalSinceNow: context.attributes.timeLeft), countsDown: true)
                        .monospacedDigit()
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom")
                    // more content
                }
            } compactLeading: {
                Text("🍕")
            } compactTrailing: {
                Text(timerInterval: Date.now...Date(timeIntervalSinceNow: context.attributes.timeLeft), countsDown: true)
                    .monospacedDigit()
            } minimal: {
                Text(timerInterval: Date.now...Date(timeIntervalSinceNow: context.attributes.timeLeft), countsDown: true)
                    .monospacedDigit()
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension PizzaLiveTimerAttributes {
    fileprivate static var preview: PizzaLiveTimerAttributes {
        PizzaLiveTimerAttributes(timeLeft: 400)
    }
}

#Preview("Notification", as: .content, using: PizzaLiveTimerAttributes.preview) {
   PizzaLiveTimerLiveActivity()
} contentStates: {
    PizzaLiveTimerAttributes.ContentState.init()}

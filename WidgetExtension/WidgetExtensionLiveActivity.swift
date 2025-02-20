//
// Created by Inditex on 20/2/25
//

import ActivityKit
import WidgetKit
import SwiftUI

struct CharacterAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        var name: String
        var image: String
        var status: Bool
        var species: String
    }
}

struct WidgetExtensionLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: CharacterAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.name)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    Text(context.state.species)
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text(context.state.status ? "Alive" : "Dead")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text(context.state.name)
                }
            } compactLeading: {
                Text(context.state.species == "Human" ? "🌎" : "👽")
            } compactTrailing: {
                Text(context.state.status ? "🟢" : "🔴")
            } minimal: {
                Text("🟡")
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

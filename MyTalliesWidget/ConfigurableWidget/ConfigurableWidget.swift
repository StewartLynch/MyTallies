//
//----------------------------------------------
// Original project: MyTallies
// by  Stewart Lynch on 2024-10-05
//
// Follow me on Mastodon: @StewartLynch@iosdev.space
// Follow me on Threads: @StewartLynch (https://www.threads.net)
// Follow me on X: https://x.com/StewartLynch
// Follow me on LinkedIn: https://linkedin.com/in/StewartLynch
// Subscribe on YouTube: https://youTube.com/@StewartLynch
// Buy me a ko-fi:  https://ko-fi.com/StewartLynch
//----------------------------------------------
// Copyright © 2024 CreaTECH Solutions. All rights reserved.



import WidgetKit
import SwiftUI
import SwiftData

struct ConfigWidgetProvider: AppIntentTimelineProvider {
    var container: ModelContainer = {
        try! ModelContainer(for: Tally.self)
    }()
    
    func placeholder(in context: Context) -> ConfigurableEntry {
        ConfigurableEntry(date: Date(), configuration: ConfigurationAppIntent(), selectedTally: nil)
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> ConfigurableEntry {
        let selectedTally = try? await getTally(name: configuration.selectedTally?.id)
       return ConfigurableEntry(date: Date(), configuration: configuration, selectedTally: selectedTally)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<ConfigurableEntry> {
        let currentDate = Date.now
        let selectedTally = try? await getTally(name: configuration.selectedTally?.id)
        let entry = ConfigurableEntry(date: currentDate, configuration: configuration, selectedTally: selectedTally)
        return Timeline(entries: [entry], policy: .atEnd)
    }
    @MainActor func getTally(name: String?) throws -> Tally? {
        guard let name else { return nil }
        let predicate = #Predicate<Tally> { $0.name == name }
        let descriptor = FetchDescriptor<Tally>(predicate: predicate)
        let foundTallies = try? container.mainContext.fetch(descriptor)
        return foundTallies?.first
    }
}

struct ConfigurableEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
    let selectedTally: Tally?
}

struct ConfigurableWidgetEntryView : View {
    var entry: ConfigWidgetProvider.Entry

    var body: some View {
        if entry.selectedTally == nil {
            ContentUnavailableView("No Tallies yet", systemImage: "plus.circle.fill")
        } else {
            SingleTallyView(size: 60, tally: entry.selectedTally!)
        }
    }
}

struct ConfigurableWidget: Widget {
    let kind: String = "ConfigurableWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: ConfigWidgetProvider()) { entry in
            ConfigurableWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .configurationDisplayName("Tally")
        .description("Update your Tally")
        .supportedFamilies([.systemSmall])
        .contentMarginsDisabled()
    }
}

#Preview(as: .systemSmall) {
    ConfigurableWidget()
} timeline: {
    ConfigurableEntry(date: .now, configuration: ConfigurationAppIntent(), selectedTally: nil)
}

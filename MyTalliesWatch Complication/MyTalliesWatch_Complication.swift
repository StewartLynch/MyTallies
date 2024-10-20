//
//----------------------------------------------
// Original project: MyTallies
// by  Stewart Lynch on 2024-10-20
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

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> WatchTallyEntry {
        WatchTallyEntry(date: Date(), tally: nil)
    }

    func getSnapshot(in context: Context, completion: @escaping (WatchTallyEntry) -> ()) {
        let currentDate = Date.now
        let tally = SharedTally.getTally()
        let entry = WatchTallyEntry(date: currentDate, tally: tally)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let currentDate = Date.now
        let tally = SharedTally.getTally()
        let entry = WatchTallyEntry(date: currentDate, tally: tally)
        let timelineEntry = Timeline(entries: [entry], policy: .never)
        completion(timelineEntry)
    }
}

struct WatchTallyEntry: TimelineEntry {
    let date: Date
    let tally: WatchTally?
}

struct MyTalliesWatch_ComplicationEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        if entry.tally == nil {
            Image(.smallComplication)
        } else {
            Text("\(entry.tally!.value)")
                .padding()
                .background(RoundedRectangle(cornerRadius: 5).stroke(.white, lineWidth: 2))
        }
    }
}

@main
struct MyTalliesWatch_Complication: Widget {
    let kind: String = "MyTalliesWatch_Complication"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
                MyTalliesWatch_ComplicationEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
        }
        .configurationDisplayName("My Tallies")
        .description("Launch MyTallies from the watch")
        .supportedFamilies([.accessoryCircular])
    }
}

#Preview(as: .accessoryRectangular) {
    MyTalliesWatch_Complication()
} timeline: {
    WatchTallyEntry(date: .now, tally: nil)
}

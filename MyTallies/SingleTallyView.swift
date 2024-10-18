//
//----------------------------------------------
// Original project: MyTallies
// by  Stewart Lynch on 2024-10-02
//
// Follow me on Mastodon: @StewartLynch@iosdev.space
// Follow me on Threads: @StewartLynch (https://www.threads.net)
// Follow me on X: https://x.com/StewartLynch
// Follow me on LinkedIn: https://linkedin.com/in/StewartLynch
// Subscribe on YouTube: https://youTube.com/@StewartLynch
// Buy me a ko-fi:  https://ko-fi.com/StewartLynch
//----------------------------------------------
// Copyright © 2024 CreaTECH Solutions. All rights reserved.


import SwiftUI
import SwiftData
import WidgetKit

struct SingleTallyView: View {
    let size: Double
    @Bindable var tally: Tally
    @Environment(\.modelContext) var context
    var body: some View {
        Text("\(tally.value)")
            .font(.system(size: size, weight: .heavy, design: .rounded))
            .monospacedDigit()
            .contentTransition(.numericText())
            .minimumScaleFactor(0.5)
            .padding()
            .frame(width: size * 1.5, height: size * 1.5)
            .background(RoundedRectangle(cornerRadius: 20).fill(.clear).stroke(.primary, lineWidth: 5))
    }
}

#Preview {
    @Previewable @State var tally = Tally(name: "Alpha")
    SingleTallyView(size: 100, tally: tally)
}

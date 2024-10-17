//
//----------------------------------------------
// Original project: MyTallies
// by  Stewart Lynch on 2024-10-17
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

struct MyTalliesListView: View {
    @Environment(TallyManager.self) var tallyManager
    @Environment(\.dismiss) var dismiss
    var body: some View {
        List(tallyManager.tallies) { tally in
            Button {
                tallyManager.selectedTally = tally
                dismiss()
            } label: {
                HStack {
                    Text(tally.name)
                    Spacer()
                    Text(tally.value, format: .number)
                }
            }
        }
    }
}

#Preview(traits: .mockData) {
    MyTalliesListView()
}

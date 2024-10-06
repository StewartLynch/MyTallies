//
//----------------------------------------------
// Original project: MyTallies
// by  Stewart Lynch on 2024-10-06
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

struct TallyUpdatedView: View {
    let tallyName: String
    let newValue: Int
    var body: some View {
        HStack {
            Text("\(newValue)")
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 3))
            Text("\(tallyName) has been updated")
        }
        .font(.largeTitle)
        .padding()
        .background(Color(.systemBackground))
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    TallyUpdatedView(tallyName: "Beta", newValue: 35)
}

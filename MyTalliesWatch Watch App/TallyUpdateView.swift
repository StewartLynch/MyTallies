//
//----------------------------------------------
// Original project: MyTallies
// by  Stewart Lynch on 2024-10-16
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

struct TallyUpdateView: View {
    let connectivity = watchOSConnectivity.shared
    @Environment(TallyManager.self) var tallyManager
    @State private var changeSelected = false
    var body: some View {
        NavigationStack {
            Group {
                if tallyManager.tallies.isEmpty {
                    ContentUnavailableView("Launch the app on the iPhone", image: "CUImage")
                } else {
                    SingleTallyView()
                }
            }
            .sheet(isPresented: $changeSelected) {
                MyTalliesListView()
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        changeSelected.toggle()
                    } label: {
                        Image(systemName: "list.bullet")
                    }
                }
            }
        }
    }
}

#Preview(traits: .mockData) {
    TallyUpdateView()
       
}

//
//----------------------------------------------
// Original project: MyTallies
// by  Stewart Lynch on 9/28/24
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

@main
struct MyTalliesApp: App {
    @State private var router = Router()
    init() {
        MyTalliesShortcuts.updateAppShortcutParameters()
    }
    var body: some Scene {
        WindowGroup {
            TallySelectionView()
                .onOpenURL { url in
                    guard url.scheme == "mtls",
                          url.host == "tally" else { return }
                    // Route to correct tally
                    router.tallyName = url.lastPathComponent
                }
        }
        .modelContainer(for: Tally.self)
        .environment(router)
    }
}

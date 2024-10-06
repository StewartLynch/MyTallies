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


import AppIntents

struct MyTalliesShortcuts: AppShortcutsProvider {
    static var appShortcuts: [AppShortcut] {
//        AppShortcut(
//            intent: UpdateTallyIntent(),
//            phrases: [
//                "Update \(.applicationName)"
//            ],
//            shortTitle: "Update first tally",
//            systemImageName: "1.circle.fill"
//        )
        AppShortcut(
            intent: UpdateNamedTallyIntent(),
            phrases: [
                "Update \(.applicationName)",
                "Update \(\.$nameEntity) with \(.applicationName)"
            ],
            shortTitle: "Update selected tally",
            systemImageName: "plus.circle.fill"
        )
    }
}

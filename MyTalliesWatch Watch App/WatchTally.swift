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


import Foundation

struct WatchTally: Identifiable, Hashable, Codable {
    var name: String
    var value: Int = 0
    var id: String { name }
    
    static var mockTallies: [WatchTally] {
        [
            WatchTally(name: "Alpha"),
            WatchTally(name: "Beta", value: 10)
        ]
    }
}

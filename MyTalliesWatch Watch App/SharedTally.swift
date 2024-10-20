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


import Foundation

class SharedTally {
    static let defaultsGroup: UserDefaults? = UserDefaults(suiteName: "group.createchsol.com.MyTallies")
    static var key = "tally"
    
    static func update(tally: WatchTally?) {
        if let tally {
            if let tallyData = try? JSONEncoder().encode(tally) {
                let tallyJSON = String(data: tallyData, encoding: .utf8)
                defaultsGroup?.set(tallyJSON, forKey: key)
            }
        }
    }
    
    static func getTally() -> WatchTally? {
        if let tallyJSON = defaultsGroup?.string(forKey: key) {
            let tallyData = Data(tallyJSON.utf8)
            return try? JSONDecoder().decode(WatchTally.self, from: tallyData)
        }
        return nil
    }
}

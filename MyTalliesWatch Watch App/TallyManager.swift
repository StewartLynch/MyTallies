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

@Observable
class TallyManager {
    static let shared = TallyManager()
    var tallies: [WatchTally] = []
    var selectedTally: WatchTally?
    
    func updateTallies(tallies: [WatchTally]) {
        self.tallies = tallies
        self.selectedTally = tallies.first
    }
    
    func increaseSelected() {
        if let index = tallies.firstIndex(where: {$0.name == selectedTally?.name}) {
            tallies[index].value += 1
            selectedTally?.value += 1
        }
    }
}

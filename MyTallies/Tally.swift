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


import Foundation
import SwiftData

@Model
class Tally {
    var name: String
    var value: Int
    init(name: String, value: Int = 0) {
        self.name = name
        self.value = value
    }
    
    func increase() {
        value += 1
    }
    
    func decrease() {
        if value > 0 {
            value -= 1
        }
    }
    
    func reset() {
        value = 0
    }
    
    static var mockTallies: [Tally] {
        [
            Tally(name: "Alpha"),
            Tally(name: "Beta", value: 10)
        ]
    }
}

//
//----------------------------------------------
// Original project: MyTallies
// by  Stewart Lynch on 2024-10-05
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
class Router {
    var tallyName: String?
    init(tallyName: String? = nil) {
        self.tallyName = tallyName
    }
}

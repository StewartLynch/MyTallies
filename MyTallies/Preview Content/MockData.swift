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


import SwiftData
import SwiftUI

struct MockData: PreviewModifier {
    func body(content: Content, context: ModelContainer) -> some View {
        content
            .modelContainer(context)
    }
    static func makeSharedContext() async throws -> ModelContainer {
        let container = try! ModelContainer(
            for: Tally.self,
            configurations: ModelConfiguration(isStoredInMemoryOnly: true)
        )
        // Insert objects here
        Tally.mockTallies.forEach { tally in
            container.mainContext.insert(tally)
        }
        
        
        return container
    }
    
    
}

extension PreviewTrait where T == Preview.ViewTraits {
    static var mockData: Self = .modifier(MockData())
}

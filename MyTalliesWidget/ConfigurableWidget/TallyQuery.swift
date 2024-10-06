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
import SwiftData

struct TallyQuery: EntityQuery {
    func entities(for identifiers: [String]) async throws -> [TallyEntity] {
        try await suggestedEntities().filter({identifiers.contains($0.id)})
    }
    
    @MainActor func suggestedEntities() async throws -> [TallyEntity] {
        let container = try! ModelContainer(for: Tally.self)
        let sort = [SortDescriptor(\Tally.name)]
        let descriptor = FetchDescriptor<Tally>(sortBy: sort)
        let allTallies = try? container.mainContext.fetch(descriptor)
        let allEntities = allTallies?.map({ tally in
            TallyEntity(id: tally.name)
        })
        return allEntities ?? []
    }
}

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


import Foundation
import WatchConnectivity
import SwiftData
import WidgetKit

class iOSConnectivity: NSObject, WCSessionDelegate {
    static let shared = iOSConnectivity()
    var id = UUID()
    
    override init() {
        super.init()
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }
    
    func session(
        _ session: WCSession,
        activationDidCompleteWith activationState: WCSessionActivationState,
        error: (any Error)?
    ) {
        Task { @MainActor in
            if activationState == .activated {
                if session.isWatchAppInstalled {
                    print("✅ Watch app is installed")
                }
            }
        }
    }

    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }

    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    
    func setContext(to payload: [String : Any]) {
        let session = WCSession.default
        if session.activationState == .activated {
            do {
                try session.updateApplicationContext(payload)
            } catch {
                print("Updating context failed")
            }
        }
    }

    func sendUpdatedTallies(tallies: [Tally]) {
        var watchTallies = tallies.map { WatchTally(name: $0.name, value: $0.value)}
        if let tallyData = try? JSONEncoder().encode(watchTallies) {
            let talliesPayload: [String : Any] = ["tallies" : tallyData]
            setContext(to: talliesPayload)
        }
    }
    
    func updateSelectedTally(selectedTally: Tally?) {
        if let selectedTally {
            let watchTally = WatchTally(name: selectedTally.name, value: selectedTally.value)
            if let payloadData = try? JSONEncoder().encode(watchTally) {
                let updatePayload: [String : Any] = ["update" : payloadData]
                setContext(to: updatePayload)
            }
        }
    }
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        Task { @MainActor in
            if let updatedTally = applicationContext["update"] as? Data {
                if let decodedUpdate = try? JSONDecoder().decode(WatchTally.self, from: updatedTally) {
                    let container = try! ModelContainer(for: Tally.self)
                    let predicate = #Predicate<Tally> { $0.name == decodedUpdate.name}
                    let descriptor = FetchDescriptor<Tally>(predicate: predicate)
                    let foundTallies = try? container.mainContext.fetch(descriptor)
                    if let tally = foundTallies?.first {
                        tally.value = decodedUpdate.value
                        try? container.mainContext.save()
                        WidgetCenter.shared.reloadAllTimelines()
                        id = UUID()
                    }
                }
            }
        }
    }

    
}

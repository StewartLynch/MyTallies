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
import SwiftUI
import WidgetKit

class watchOSConnectivity: NSObject, WCSessionDelegate {
    static let shared = watchOSConnectivity()
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
        
    }
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        Task { @MainActor in
            let tallyManager = TallyManager.shared
            if let watchTallies = applicationContext["tallies"] as? Data {
                if let decodedTallies = try? JSONDecoder().decode([WatchTally].self, from: watchTallies) {
                    tallyManager.tallies = decodedTallies
                    tallyManager.selectedTally = decodedTallies.first
                    SharedTally.update(tally: tallyManager.selectedTally)
                    WidgetCenter.shared.reloadAllTimelines()
                } else {
                    print("Failed to decode tallies JSON")
                }
            } else {
                if let updatedTally = applicationContext["update"] as? Data {
                    if let decodedUpdate = try? JSONDecoder().decode(WatchTally.self, from: updatedTally) {
                        if let index = tallyManager.tallies.firstIndex(where: {$0.name == decodedUpdate.name}) {
                            tallyManager.tallies[index].value = decodedUpdate.value
                            if tallyManager.selectedTally?.name == decodedUpdate.name {
                                withAnimation {
                                    tallyManager.selectedTally?.value = decodedUpdate.value
                                    SharedTally.update(tally: tallyManager.selectedTally)
                                    WidgetCenter.shared.reloadAllTimelines()
                                }
                            }
                        }
                    }
                }
            }
        }
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
    
    func updateSelectedTally(selectedTally: WatchTally?) {
        if let selectedTally {
            if let jsonData = try? JSONEncoder().encode(selectedTally) {
                let updatePayload: [String : Any] = ["update" : jsonData]
                setContext(to: updatePayload)
            }
        }
    }

    
}

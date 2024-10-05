//
//----------------------------------------------
// Original project: MyTallies
// by  Stewart Lynch on 9/28/24
//
// Follow me on Mastodon: @StewartLynch@iosdev.space
// Follow me on Threads: @StewartLynch (https://www.threads.net)
// Follow me on X: https://x.com/StewartLynch
// Follow me on LinkedIn: https://linkedin.com/in/StewartLynch
// Subscribe on YouTube: https://youTube.com/@StewartLynch
// Buy me a ko-fi:  https://ko-fi.com/StewartLynch
//----------------------------------------------
// Copyright © 2024 CreaTECH Solutions. All rights reserved.


import SwiftUI
import SwiftData
import WidgetKit

struct TallySelectionView: View {
    @Environment(Router.self) var router
    @Query(sort: \Tally.name) var tallies: [Tally]
    @State private var selectedTally: Tally?
    @Environment(\.modelContext) var context
    @State private var newTally = false
    @Environment(\.scenePhase) var scenePhase
    @State private var id = UUID()
    var body: some View {
        NavigationStack {
            VStack {
                if tallies.isEmpty {
                    ContentUnavailableView("Create your first tally", image: "mac256")
                } else {
                    Picker("Select your tally", selection: $selectedTally) {
                        Text("Select Tally").tag(nil as Tally?)
                        ForEach(tallies) { tally in
                            Text(tally.name).tag(tally as Tally?)
                        }
                    }
                    .buttonStyle(.bordered)
                    .padding()
                    if selectedTally != nil {
                        SingleTallyView(size: 100, tally: selectedTally!)
                        Button {
                            withAnimation {
                                selectedTally?.reset()
                                try? context.save()
                                WidgetCenter.shared.reloadAllTimelines()
                            }
                        } label: {
                            Label("Reset", systemImage: "arrow.counterclockwise")
                        }
                        .font(.title)
                        .buttonStyle(.bordered)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding()
                    }
                    Spacer()
                }
            }
            .id(id)
            .navigationTitle("My Tallies")
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    if !tallies.isEmpty {
                        Button {
                            if let selectedTally {
                                context.delete(selectedTally)
                                try? context.save()
                                WidgetCenter.shared.reloadAllTimelines()
                                if !tallies.isEmpty {
                                    self.selectedTally = tallies.first!
                                }
                            }
                        } label: {
                            Image(systemName: "trash")
                                .foregroundStyle(.red)
                        }
                    }
                    Button {
                        newTally = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .imageScale(.large)
                    }
                }
            }
            .sheet(isPresented: $newTally) {
                NewTallyView(selectedTally: self.$selectedTally)
                    .presentationDetents([.height(250)])
            }
            .onAppear {
                if !tallies.isEmpty {
                    selectedTally = tallies.first!
                }
            }
            .onChange(of: scenePhase) {
                if scenePhase == .active {
                    id = UUID()
                }
            }
            .onChange(of: router.tallyName) { oldValue, newValue in
                if newValue != selectedTally?.name {
                    selectedTally = tallies.first(where: {$0.name == newValue})
                }
            }
        }
    }
}

#Preview(traits: .mockData) {
    TallySelectionView()
        .environment(Router())
}

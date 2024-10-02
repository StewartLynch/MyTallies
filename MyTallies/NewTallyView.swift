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


import SwiftUI
import SwiftData

struct NewTallyView: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    @Query var tallies: [Tally]
    @Binding var selectedTally: Tally?
    @State private var name: String = ""
    var body: some View {
        NavigationStack {
            VStack {
                TextField("name", text: $name)
                    .textFieldStyle(.roundedBorder)
                Button("Add") {
                    let newTally = Tally(name: name)
                    context.insert(newTally)
                    try? context.save()
                    selectedTally = newTally
                    dismiss()
                }
                .buttonStyle(.bordered)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .disabled(name.isEmpty || tallies.map{$0.name}.contains(name))
                Spacer()
            }
            .padding()
            .navigationTitle("New Tally")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                }
            }
        }
    }
}

#Preview {
    NewTallyView(selectedTally: .constant(nil))
}

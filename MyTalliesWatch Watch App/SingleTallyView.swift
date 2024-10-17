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


import SwiftUI

struct SingleTallyView: View {
    @Environment(TallyManager.self) var tallyManager
    var body: some View {
        if tallyManager.selectedTally != nil {
            VStack {
                Text("\(tallyManager.selectedTally!.value)")
                    .font(.system(size: 80, weight: .heavy, design: .rounded))
                    .monospacedDigit()
                    .contentTransition(.numericText())
                    .minimumScaleFactor(0.5)
                    .padding()
                    .frame(width: 80 * 1.5, height: 80 * 1.5)
                    .background(RoundedRectangle(cornerRadius: 20).fill(.clear).stroke(.primary, lineWidth: 5))
                Text(tallyManager.selectedTally!.name)
                    .font(.title3)
            }
            .onTapGesture {
                withAnimation {
                    tallyManager.increaseSelected()
                }
            }
        }
    }
}

#Preview(traits: .mockData) {
    SingleTallyView()
}

struct MockData: PreviewModifier {
    func body(content: Content, context: Void) -> some View {
        @Previewable @State var tallyManager = TallyManager()
        tallyManager.updateTallies(tallies: WatchTally.mockTallies)
        return content
            .environment(tallyManager)
    }
}

extension PreviewTrait where T == Preview.ViewTraits {
    static var mockData: Self = .modifier(MockData())
}

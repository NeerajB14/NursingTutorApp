import SwiftUI

struct CommunityView: View {
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Connect with Peers")) { NavigationLink(destination: StudyGroupsView()) { Label("Find a Study Group", systemImage: "person.2.wave.2.fill") } }
                Section(header: Text("Discussion Forums (Coming Soon)")) {
                    Label("Pharmacology", systemImage: "text.bubble.fill")
                    Label("Clinical Stories", systemImage: "text.bubble.fill")
                }
            }.listStyle(GroupedListStyle()).navigationTitle("Community")
        }
    }
}

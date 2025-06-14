import SwiftUI

struct StudyGroupsView: View {
    var body: some View {
        List {
            Section { Button("Create a New Study Group") {} }
            Section(header: Text("Groups by Exam Date")) {
                VStack(alignment: .leading) { Text("NCLEX Takers - July 2025").font(.headline); Text("32 Members").font(.caption) }.padding(.vertical, 5)
            }
            Section(header: Text("Groups by Topic")) {
                VStack(alignment: .leading) { Text("Pediatrics Focus Group").font(.headline); Text("12 Members").font(.caption) }.padding(.vertical, 5)
            }
        }.navigationTitle("Study Groups")
    }
}

import SwiftUI

struct GroupSessionsView: View {
    var body: some View {
        List {
            Section(header: Text("Upcoming Q&A Discussions")) {
                VStack(alignment: .leading, spacing: 5) {
                    Text("Pharmacology Power Hour").font(.headline)
                    Label("With Dr. Alex Ray", systemImage: "person.fill")
                    Label("June 15, 2025 at 7:00 PM EST", systemImage: "calendar")
                }.padding(.vertical)
                VStack(alignment: .leading, spacing: 5) {
                    Text("Pediatric Case Studies").font(.headline)
                    Label("With Dr. Maria Garcia", systemImage: "person.fill")
                    Label("June 17, 2025 at 8:00 PM EST", systemImage: "calendar")
                }.padding(.vertical)
            }
        }.navigationTitle("Group Sessions")
    }
}

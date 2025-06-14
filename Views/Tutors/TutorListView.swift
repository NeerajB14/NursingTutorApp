import SwiftUI

struct TutorListView: View {
    let tutors = [
        Tutor(name: "Dr. Alex Ray", specialty: "Med-Surg, Cardiology", rating: 4.9),
        Tutor(name: "Dr. Maria Garcia", specialty: "Pediatrics, OB/GYN", rating: 4.8),
        Tutor(name: "John Carter, RN", specialty: "Psychiatric Nursing", rating: 4.9)
    ]

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Asynchronous Support")) {
                    NavigationLink(destination: AskTutorView()) {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Ask a Tutor").font(.headline)
                            Text("Submit a question and get a detailed answer.").font(.subheadline).foregroundColor(.secondary)
                        }.padding(.vertical, 8)
                    }
                }
                Section(header: Text("Group Sessions")) { NavigationLink(destination: GroupSessionsView()) { Label("Join a Group Session", systemImage: "person.3.fill") } }
                Section(header: Text("Live 1:1 Tutoring")) {
                    ForEach(tutors) { tutor in NavigationLink(destination: TutorDetailView(tutor: tutor)) { TutorRowView(tutor: tutor) } }
                }
            }.listStyle(GroupedListStyle()).navigationTitle("Find a Tutor")
        }
    }
}

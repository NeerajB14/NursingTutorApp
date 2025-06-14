import SwiftUI

struct AllCoursesView: View {
    let allTopics = [
        CourseTopic(name: "Fundamentals", icon: "doc.text.magnifyingglass"),
        CourseTopic(name: "Pharmacology", icon: "pills.fill"),
        CourseTopic(name: "Medical-Surgical", icon: "cross.vial.fill"),
        CourseTopic(name: "Pediatrics", icon: "figure.and.child.holdinghands"),
        CourseTopic(name: "Obstetrics (OB)", icon: "person.2.circle"),
        CourseTopic(name: "Psychiatric Health", icon: "brain.head.profile"),
        CourseTopic(name: "Community Health", icon: "person.3.fill"),
        CourseTopic(name: "Leadership & Mgmt", icon: "crown.fill")
    ]
    let columns = [GridItem(.adaptive(minimum: 150))]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(allTopics) { topic in
                    NavigationLink(destination: CourseDetailView(topic: topic)) {
                        TopicCard(topic: topic).frame(height: 120)
                    }.buttonStyle(.plain)
                }
            }.padding()
        }.navigationTitle("All Courses")
    }
}

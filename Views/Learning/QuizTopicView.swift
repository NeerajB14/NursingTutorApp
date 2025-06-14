import SwiftUI

struct QuizTopicView: View {
    let topics = [
        CourseTopic(name: "Pharmacology", icon: "pills.fill"),
        CourseTopic(name: "Medical-Surgical", icon: "cross.vial.fill"),
        CourseTopic(name: "Pediatrics", icon: "figure.and.child.holdinghands"),
        CourseTopic(name: "Psychiatric Health", icon: "brain.head.profile")
    ]
    
    var body: some View {
        List(topics) { topic in
            NavigationLink(destination: QuizView(topic: topic)) { Label(topic.name, systemImage: topic.icon) }
        }.navigationTitle("Select Quiz Topic")
    }
}

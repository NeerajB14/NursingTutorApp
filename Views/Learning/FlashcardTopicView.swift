import SwiftUI

struct FlashcardTopicView: View {
    let topics = [
        CourseTopic(name: "Lab Values", icon: "testtube.2"),
        CourseTopic(name: "Pharmacology Suffixes", icon: "pills.fill"),
        CourseTopic(name: "Common Abbreviations", icon: "a.magnify")
    ]
    
    var body: some View {
        List(topics) { topic in
            NavigationLink(destination: FlashcardView(topic: topic)) { Label(topic.name, systemImage: topic.icon) }
        }.navigationTitle("Select Flashcards")
    }
}

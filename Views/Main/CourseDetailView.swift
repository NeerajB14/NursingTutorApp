import SwiftUI

struct CourseDetailView: View {
    let topic: CourseTopic
    
    var body: some View {
        List {
            Section(header: Text("Study Tools for \(topic.name)")) {
                NavigationLink("Practice Quiz", destination: QuizView(topic: topic))
                NavigationLink("Flashcards", destination: FlashcardView(topic: topic))
            }
            Section(header: Text("About This Course")) {
                Text("This section will contain details about the \(topic.name) course, including key concepts, learning objectives, and relevant NCLEX categories based on Saunders and ATI textbooks.").padding(.vertical)
            }
        }.listStyle(GroupedListStyle()).navigationTitle(topic.name)
    }
}

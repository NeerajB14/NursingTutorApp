import SwiftUI

struct LearningToolsView: View {
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Study Aids")) {
                    NavigationLink(destination: QuizTopicView()) { Label("Practice Quizzes", systemImage: "questionmark.diamond.fill") }
                    NavigationLink(destination: FlashcardTopicView()) { Label("Flashcards", systemImage: "rectangle.stack.fill") }
                }
                Section(header: Text("Multimedia")) {
                    NavigationLink(destination: VideoLecturesView()) { Label("Mini Video Lectures", systemImage: "video.fill") }
                    NavigationLink(destination: ConceptMapsView()) { Label("Concept Maps & Guides", systemImage: "map.fill") }
                }
            }.navigationTitle("Learning Tools")
        }
    }
}

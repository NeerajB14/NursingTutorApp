import SwiftUI

struct AskTutorView: View {
    @State private var question: String = "Type your question here..."
    @State private var topic: String = "Med-Surg"
    let topics = ["Med-Surg", "Pediatrics", "Pharmacology", "Fundamentals"]

    var body: some View {
        Form {
            Section(header: Text("Select Topic")) { Picker("Topic", selection: $topic) { ForEach(topics, id: \.self) { Text($0) } } }
            Section(header: Text("Your Question")) {
                TextEditor(text: $question).frame(height: 200)
                    .foregroundColor(question == "Type your question here..." ? .gray : .primary)
                    .onTapGesture { if self.question == "Type your question here..." { self.question = "" } }
            }
            Section { Button("Submit Question") {} }
        }.navigationTitle("Ask a Tutor")
    }
}

import SwiftUI

struct SendFeedbackView: View {
    @State private var feedbackText: String = "Please share your thoughts or report an issue..."
    
    var body: some View {
        Form {
            Section(header: Text("Your Feedback")) {
                TextEditor(text: $feedbackText).frame(height: 200)
                    .foregroundColor(feedbackText == "Please share your thoughts or report an issue..." ? .gray : .primary)
                    .onTapGesture {
                        if self.feedbackText == "Please share your thoughts or report an issue..." { self.feedbackText = "" }
                    }
            }
            Section { Button("Submit Feedback") {} }
        }.navigationTitle("Send Feedback")
    }
}

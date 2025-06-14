import SwiftUI

struct QuizHistoryView: View {
    var body: some View {
        List {
            VStack(alignment: .leading) {
                Text("Pharmacology Quiz").font(.headline)
                Text("Score: 9/10 - Completed June 14, 2025").font(.caption)
            }.padding(.vertical, 5)
            VStack(alignment: .leading) {
                Text("Med-Surg Quiz").font(.headline)
                Text("Score: 7/10 - Completed June 12, 2025").font(.caption)
            }.padding(.vertical, 5)
        }.navigationTitle("Quiz History")
    }
}

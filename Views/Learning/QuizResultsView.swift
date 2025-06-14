import SwiftUI

struct QuizResultsView: View {
    @Environment(\.presentationMode) var presentationMode
    let score: Int
    let totalQuestions: Int
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Quiz Complete!").font(.largeTitle).fontWeight(.bold)
            Text("Your Score:").font(.title2)
            Text("\(score) / \(totalQuestions)").font(.system(size: 60, weight: .bold)).foregroundColor(Color.appPrimary)
            Text(score > (totalQuestions / 2) ? "Great Job!" : "Keep Practicing!").font(.headline)
            Spacer()
            Button(action: { self.presentationMode.wrappedValue.dismiss() }) {
                Text("Back to Topics").font(.headline).foregroundColor(.white).frame(maxWidth: .infinity).padding().background(Color.appSecondary).cornerRadius(10)
            }
        }.padding()
    }
}

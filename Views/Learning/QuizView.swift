import SwiftUI

struct QuizView: View {
    let topic: CourseTopic
    private let aiService = AIService()
    
    @State private var questions: [QuizQuestion] = []
    @State private var isLoading = true
    @State private var errorMessage: String?
    
    @State private var currentQuestionIndex = 0
    @State private var selectedOption: Int?
    @State private var showRationale = false
    @State private var score = 0
    @State private var quizFinished = false

    var body: some View {
        ZStack {
            if isLoading {
                ProgressView("Generating New Quiz...")
            } else if let errorMessage = errorMessage {
                VStack {
                    Text("Error").font(.headline)
                    Text(errorMessage).padding()
                    Button("Retry") {
                        Task { await generateQuestions() }
                    }
                }
            } else if quizFinished {
                QuizResultsView(score: score, totalQuestions: questions.count)
            } else if !questions.isEmpty {
                quizContent
            }
        }
        .navigationTitle(topic.name)
        .task {
            await generateQuestions()
        }
    }
    
    func generateQuestions() async {
        isLoading = true
        errorMessage = nil
        aiService.generateQuizQuestions(topic: topic.name, count: 5) { result in
            DispatchQueue.main.async {
                isLoading = false
                switch result {
                case .success(let fetchedQuestions):
                    self.questions = fetchedQuestions
                    resetQuizState()
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func resetQuizState() {
        currentQuestionIndex = 0
        score = 0
        selectedOption = nil
        showRationale = false
        quizFinished = false
    }

    var quizContent: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Question \(currentQuestionIndex + 1) of \(questions.count)")
                .font(.headline)
                .fontWeight(.bold)

            ProgressView(value: Double(currentQuestionIndex), total: Double(questions.count))
                .accentColor(Color.appPrimary)

            Text(questions[currentQuestionIndex].text)
                .font(.title3)
                .fontWeight(.medium)
                .padding(.vertical)

            ForEach(0..<questions[currentQuestionIndex].options.count, id: \.self) { index in
                Button(action: {
                    if selectedOption == nil {
                        selectedOption = index
                        if index == questions[currentQuestionIndex].correctAnswerIndex {
                            score += 1
                        }
                        withAnimation {
                            showRationale = true
                        }
                    }
                }) {
                    HStack {
                        Text(questions[currentQuestionIndex].options[index])
                        Spacer()
                        if selectedOption == index {
                            Image(systemName: index == questions[currentQuestionIndex].correctAnswerIndex ? "checkmark.circle.fill" : "xmark.circle.fill")
                                .foregroundColor(index == questions[currentQuestionIndex].correctAnswerIndex ? .green : .red)
                        }
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(selectedOption == index ? (index == questions[currentQuestionIndex].correctAnswerIndex ? Color.green : Color.red) : Color.clear, lineWidth: 2)
                )
                .foregroundColor(.primary)
                .disabled(selectedOption != nil)
            }
            
            if showRationale {
                VStack(alignment: .leading) {
                    Text("Rationale")
                        .font(.headline)
                    Text(questions[currentQuestionIndex].rationale)
                        .font(.subheadline)
                }
                .padding()
                .background(Color.appSecondary.opacity(0.2))
                .cornerRadius(10)
            }
            
            Spacer()
            
            Button(action: {
                if currentQuestionIndex < questions.count - 1 {
                    currentQuestionIndex += 1
                    selectedOption = nil
                    showRationale = false
                } else {
                    quizFinished = true
                }
            }) {
                Text(currentQuestionIndex < questions.count - 1 ? "Next Question" : "Finish Quiz")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.appPrimary)
                    .cornerRadius(10)
            }
            .disabled(selectedOption == nil)
        }
        .padding()
    }
}

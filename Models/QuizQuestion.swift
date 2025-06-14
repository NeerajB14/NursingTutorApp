import Foundation

// Now conforms to Decodable to be created from AI-generated JSON
struct QuizQuestion: Decodable, Identifiable {
    let id = UUID()
    let text: String
    let options: [String]
    let correctAnswerIndex: Int
    let rationale: String

    private enum CodingKeys: String, CodingKey {
        case text = "question"
        case options
        case correctAnswerIndex = "correctAnswer"
        case rationale
    }
}

import Foundation

// Now a proper struct that is Decodable and Identifiable
struct Flashcard: Decodable, Identifiable {
    let id = UUID()
    let front: String
    let back: String
}

import SwiftUI

struct FlashcardView: View {
    let topic: CourseTopic
    private let aiService = AIService()
    
    @State private var flashcards: [Flashcard] = []
    @State private var isLoading = true
    @State private var errorMessage: String?
    
    @State private var currentCardIndex = 0
    @State private var isFlipped = false
    @State private var rotation: Double = 0
    
    var body: some View {
        ZStack {
            if isLoading {
                ProgressView("Generating New Flashcards...")
            } else if let errorMessage = errorMessage {
                VStack {
                    Text("Error").font(.headline)
                    Text(errorMessage).padding()
                    Button("Retry") {
                        Task { await generateFlashcards() }
                    }
                }
            } else if !flashcards.isEmpty {
                flashcardContent
            }
        }
        .navigationTitle(topic.name)
        .task {
            await generateFlashcards()
        }
    }
    
    func generateFlashcards() async {
        isLoading = true
        errorMessage = nil
        aiService.generateFlashcards(topic: topic.name, count: 10) { result in
            DispatchQueue.main.async {
                isLoading = false
                switch result {
                case .success(let fetchedCards):
                    self.flashcards = fetchedCards
                    resetCard()
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    var flashcardContent: some View {
        VStack {
            ZStack {
                FlashcardSide(text: flashcards[currentCardIndex].front, color: Color.appPrimary)
                    .opacity(isFlipped ? 0 : 1)
                
                FlashcardSide(text: flashcards[currentCardIndex].back, color: Color.appSecondary)
                    .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                    .opacity(isFlipped ? 1 : 0)
            }
            .rotation3DEffect(.degrees(rotation), axis: (x: 0, y: 1, z: 0))
            .onTapGesture {
                withAnimation(.spring()) {
                    isFlipped.toggle()
                    rotation += 180
                }
            }
            .padding()

            HStack {
                Button(action: {
                    if currentCardIndex > 0 {
                        currentCardIndex -= 1
                        resetCard()
                    }
                }) {
                    Image(systemName: "arrow.left.circle.fill")
                        .font(.largeTitle)
                }
                .disabled(currentCardIndex == 0)
                
                Spacer()
                
                Text("\(currentCardIndex + 1) / \(flashcards.count)")
                
                Spacer()
                
                Button(action: {
                     if currentCardIndex < flashcards.count - 1 {
                        currentCardIndex += 1
                        resetCard()
                    }
                }) {
                    Image(systemName: "arrow.right.circle.fill")
                        .font(.largeTitle)
                }
                .disabled(currentCardIndex == flashcards.count - 1)
            }
            .padding()
            .accentColor(Color.appPrimary)
        }
    }
    
    func resetCard() {
        isFlipped = false
        rotation = 0
    }
}


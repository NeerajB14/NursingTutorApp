import SwiftUI

struct AIChatbotView: View {
    @State private var messages: [ChatMessage] = [
        ChatMessage(text: "Hello! I'm your AI assistant. Ask me any nursing question to get started.", isFromUser: false)
    ]
    @State private var currentInput: String = ""
    @State private var isAwaitingResponse = false

    var body: some View {
        NavigationView {
            VStack {
                // Chat message display area
                ScrollViewReader { proxy in
                    ScrollView {
                        VStack(spacing: 12) {
                            ForEach(messages) { message in
                                ChatBubble(message: message)
                            }
                            if isAwaitingResponse {
                                ChatBubble(message: ChatMessage(text: "Typing...", isFromUser: false))
                            }
                        }
                        .padding()
                    }
                    .onChange(of: messages.count) {
                        scrollToBottom(proxy: proxy)
                    }
                    .onChange(of: isAwaitingResponse) {
                        scrollToBottom(proxy: proxy)
                    }
                }

                // Input area
                HStack {
                    TextField("Ask a question...", text: $currentInput)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(25)
                    
                    Button(action: sendMessage) {
                        Image(systemName: "arrow.up.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(Color(red: 0.2, green: 0.6, blue: 0.8))
                    }
                    .disabled(currentInput.isEmpty || isAwaitingResponse)
                }
                .padding()
            }
            .navigationTitle("AI Assistant")
        }
    }

    func sendMessage() {
        let trimmedText = currentInput.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedText.isEmpty else { return }

        messages.append(ChatMessage(text: trimmedText, isFromUser: true))
        currentInput = ""
        isAwaitingResponse = true
        
        Task {
            await getAIResponse(for: trimmedText)
        }
    }
    
    func getAIResponse(for query: String) async {
        let apiKey = "AIzaSyAsuNn6LauKCB8sHEWuWx80IQgvXBuWc1E"
        
        // --- THIS IS THE CORRECTED URL. THE INVALID MARKDOWN IS REMOVED. ---
        let urlString = "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent?key=\(apiKey)"
        
        guard let apiUrl = URL(string: urlString) else {
            handleError("Invalid URL string.")
            return
        }
        // --- END OF CORRECTION ---
        
        var request = URLRequest(url: apiUrl)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let payload: [String: Any] = [
            "contents": [
                [
                    "role": "user",
                    "parts": [["text": "Please answer as a nursing tutor. Question: \(query)"]]
                ]
            ]
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: payload)
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            let rawResponseString = String(data: data, encoding: .utf8) ?? "Could not decode response"
            print("--- Raw API Response ---\n\(rawResponseString)\n--- End Raw API Response ---")

            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                handleError("API returned status code: \(httpResponse.statusCode). Full response: \(rawResponseString)")
                return
            }

            if let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
               let candidates = json["candidates"] as? [[String: Any]],
               let firstCandidate = candidates.first,
               let content = firstCandidate["content"] as? [String: Any],
               let parts = content["parts"] as? [[String: Any]],
               let firstPart = parts.first,
               let text = firstPart["text"] as? String {
                
                DispatchQueue.main.async {
                    let aiMessage = ChatMessage(text: text.trimmingCharacters(in: .whitespacesAndNewlines), isFromUser: false)
                    isAwaitingResponse = false
                    messages.append(aiMessage)
                }
            } else {
                handleError("Unable to parse a successful response. The server said: \(rawResponseString)")
            }
            
        } catch {
            handleError("Networking Error: \(error.localizedDescription)")
        }
    }
    
    func handleError(_ errorMessage: String) {
        DispatchQueue.main.async {
            isAwaitingResponse = false
            let errorMesssage = ChatMessage(text: "Sorry, I ran into an error: \(errorMessage)", isFromUser: false)
            messages.append(errorMesssage)
        }
    }

    private func scrollToBottom(proxy: ScrollViewProxy) {
        guard !messages.isEmpty else { return }
        let lastMessageId = messages[messages.count - 1].id
        proxy.scrollTo(lastMessageId, anchor: .bottom)
    }
}

// A view for a single chat bubble
struct ChatBubble: View {
    let message: ChatMessage
    
    var body: some View {
        HStack {
            if message.isFromUser {
                Spacer()
            }
            
            Text(message.text)
                .padding()
                .background(message.isFromUser ? Color(red: 0.2, green: 0.6, blue: 0.8) : Color.gray.opacity(0.2))
                .foregroundColor(message.isFromUser ? .white : .primary)
                .cornerRadius(15)
            
            if !message.isFromUser {
                Spacer()
            }
        }
    }
}


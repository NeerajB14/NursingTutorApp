import Foundation

class AIService {
    
    // IMPORTANT: Get your API key from https://aistudio.google.com/app/apikey
    private let apiKey = "AIzaSyAsuNn6LauKCB8sHEWuWx80IQgvXBuWc1E"
    
    private func makeAPIRequest<T: Decodable>(prompt: String, responseSchema: [String: Any], completion: @escaping (Result<T, Error>) -> Void) {
        let urlString = "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent?key=\(apiKey)"
        
        guard !apiKey.isEmpty, apiKey != "AIzaSyAsuNn6LauKCB8sHEWuWx80IQgvXBuWc1E" else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid API Key. Please get a key from Google AI Studio."])))
            return
        }
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let payload: [String: Any] = [
            "contents": [
                "role": "user",
                "parts": [["text": prompt]]
            ],
            "generationConfig": [
                "response_mime_type": "application/json",
                "response_schema": responseSchema
            ]
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: payload)
        } catch {
            completion(.failure(error))
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }
            
            do {
                if let jsonString = String(data: data, encoding: .utf8),
                   let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let candidates = jsonObject["candidates"] as? [[String: Any]],
                   let content = candidates.first?["content"] as? [String: Any],
                   let parts = content["parts"] as? [[String: Any]],
                   let textPart = parts.first?["text"] as? String {
                    
                    let cleanedText = textPart.trimmingCharacters(in: .whitespacesAndNewlines)
                    let responseData = Data(cleanedText.utf8)
                    let decodedObject = try JSONDecoder().decode(T.self, from: responseData)
                    completion(.success(decodedObject))
                } else {
                     let responseString = String(data: data, encoding: .utf8) ?? "Could not decode response"
                    completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to parse JSON response: \(responseString)"])))
                }
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }

    func generateQuizQuestions(topic: String, count: Int, completion: @escaping (Result<[QuizQuestion], Error>) -> Void) {
        let prompt = "Generate \(count) unique NCLEX-style multiple-choice questions for the nursing topic: \(topic). Each question must have exactly 4 options. Include a rationale for the correct answer."
        
        let schema: [String: Any] = [
            "type": "ARRAY",
            "items": [
                "type": "OBJECT",
                "properties": [
                    "question": ["type": "STRING"],
                    "options": ["type": "ARRAY", "items": ["type": "STRING"]],
                    "correctAnswer": ["type": "INTEGER", "description": "The 0-based index of the correct answer in the options array."],
                    "rationale": ["type": "STRING", "description": "A brief explanation of why the answer is correct."]
                ]
            ]
        ]
        
        makeAPIRequest(prompt: prompt, responseSchema: schema, completion: completion)
    }

    func generateFlashcards(topic: String, count: Int, completion: @escaping (Result<[Flashcard], Error>) -> Void) {
        let prompt = "Generate \(count) unique flashcards for the nursing topic: \(topic). Each flashcard should have a 'front' (term or question) and a 'back' (definition or answer)."

        let schema: [String: Any] = [
            "type": "ARRAY",
            "items": [
                "type": "OBJECT",
                "properties": [
                    "front": ["type": "STRING", "description": "The front side of the flashcard."],
                    "back": ["type": "STRING", "description": "The back side of the flashcard."]
                ]
            ]
        ]
        
        makeAPIRequest(prompt: prompt, responseSchema: schema, completion: completion)
    }
}

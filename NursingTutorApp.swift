import SwiftUI

@main
struct NursingTutorApp: App {
    @StateObject private var userSession = UserSession()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(userSession)
        }
    }
}

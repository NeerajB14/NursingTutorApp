import SwiftUI

struct MainTabView: View {
    @Binding var isLoggedIn: Bool

    var body: some View {
        TabView {
            HomeView().tabItem { Label("Home", systemImage: "house.fill") }
            LearningToolsView().tabItem { Label("Learn", systemImage: "book.fill") }
            
            // --- AI CHATBOT TAB IS NOW RESTORED ---
            AIChatbotView().tabItem { Label("AI Chat", systemImage: "sparkles") }
            // --- END OF CORRECTION ---
            
            TutorListView().tabItem { Label("Tutors", systemImage: "person.2.fill") }
            CommunityView().tabItem { Label("Community", systemImage: "message.fill") }
            ProfileView(isLoggedIn: $isLoggedIn).tabItem { Label("Profile", systemImage: "person.crop.circle.fill") }
        }.accentColor(Color.appPrimary)
    }
}

import SwiftUI

struct ProfileView: View {
    @Binding var isLoggedIn: Bool
    @EnvironmentObject var userSession: UserSession

    var body: some View {
        NavigationView {
            List {
                Section {
                    VStack(spacing: 15) {
                        Image(systemName: "person.circle.fill").font(.system(size: 80)).foregroundColor(.gray.opacity(0.5))
                        Text(userSession.name).font(.title).fontWeight(.bold)
                        Text(userSession.school).font(.subheadline).foregroundColor(.secondary)
                    }.frame(maxWidth: .infinity).padding(.vertical)
                }
                Section(header: Text("Learning History")) {
                    VStack(alignment: .leading) {
                        Text("Overall Progress")
                        ProgressView(value: userSession.progress, total: 100).accentColor(Color.appSecondary)
                        Text("\(Int(userSession.progress))% complete").font(.caption).foregroundColor(.secondary)
                    }.padding(.vertical, 8)
                    NavigationLink(destination: QuizHistoryView()) { Label("View Completed Quizzes", systemImage: "list.bullet.rectangle") }
                    NavigationLink(destination: BookmarksView()) { Label("View Bookmarked Flashcards", systemImage: "bookmark.fill") }
                }
                Section(header: Text("Settings")) {
                    NavigationLink(destination: EditProfileView()) { Label("Edit Profile", systemImage: "person.fill") }
                    NavigationLink(destination: NotificationsView()) { Label("Notifications", systemImage: "bell.fill") }
                    NavigationLink(destination: SubscriptionView()) { Label("Manage Subscription", systemImage: "creditcard.fill") }
                }
                Section(header: Text("Support")) { NavigationLink(destination: SendFeedbackView()) { Label("Send Feedback", systemImage: "envelope.fill") } }
                Section {
                    Button(action: { self.isLoggedIn = false }) {
                        Text("Log Out").foregroundColor(.red).frame(maxWidth: .infinity, alignment: .center)
                    }
                }
            }.listStyle(GroupedListStyle()).navigationTitle("Profile").background(Color.appBackground.edgesIgnoringSafeArea(.all))
        }
    }
}

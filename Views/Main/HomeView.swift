import SwiftUI

struct HomeView: View {
    @EnvironmentObject var userSession: UserSession

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 25) {
                    Text("Welcome back, \(userSession.name)!").font(.largeTitle).fontWeight(.bold)
                    
                    // --- NEW AI RECOMMENDATIONS SECTION ---
                    VStack(alignment: .leading) {
                        Text("Smart Recommendations")
                            .font(.title2)
                            .fontWeight(.bold)
                        Text("Based on your recent activity, we suggest focusing on:")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        VStack(spacing: 10) {
                            Text("Topic: Cardiology")
                                .font(.headline)
                            Text("Practice Quiz: Pediatric Milestones")
                                .font(.headline)
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.yellow.opacity(0.2))
                        .cornerRadius(10)
                    }
                    // --- END OF NEW SECTION ---
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Today's Goal").font(.headline)
                        Label("Complete 20 Pharmacology questions", systemImage: "target").padding().frame(maxWidth: .infinity, alignment: .leading).background(Color.appSecondary.opacity(0.2)).cornerRadius(10)
                    }
                    SectionView(title: "Upcoming Sessions", destination: FullScheduleView()) { Text("You have no upcoming sessions.").foregroundColor(.secondary) }
                    SectionView(title: "Browse by Course", destination: AllCoursesView()) {
                        HStack(spacing: 15) {
                            TopicCard(topic: CourseTopic(name: "Med-Surg", icon: "waveform.path.ecg.rectangle.fill"))
                            TopicCard(topic: CourseTopic(name: "Pediatrics", icon: "figure.and.child.holdinghands"))
                        }
                    }
                    SectionView(title: "Community Buzz", destination: CommunityView()) { Text("Hot Topic: Mnemonics for Cranial Nerves").font(.subheadline).padding(.top, 5) }
                }.padding()
            }.navigationTitle("Dashboard").navigationBarHidden(true)
        }
    }
}

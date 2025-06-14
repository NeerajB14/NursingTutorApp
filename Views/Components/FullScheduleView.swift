import SwiftUI

struct FullScheduleView: View {
    var body: some View {
        VStack(spacing: 15) {
            Image(systemName: "calendar.badge.exclamationmark").font(.system(size: 80)).foregroundColor(.secondary)
            Text("No Sessions Scheduled").font(.title).fontWeight(.bold)
            Text("Book a session with a tutor to get started.").font(.subheadline).foregroundColor(.secondary)
        }.padding().navigationTitle("My Schedule")
    }
}

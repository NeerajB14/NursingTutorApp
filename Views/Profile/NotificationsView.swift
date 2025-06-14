import SwiftUI

struct NotificationsView: View {
    @State private var dailyReminders = true
    @State private var newContentAlerts = true
    
    var body: some View {
        Form {
            Toggle("Daily Study Reminders", isOn: $dailyReminders)
            Toggle("New Content Alerts", isOn: $newContentAlerts)
        }.navigationTitle("Notifications")
    }
}

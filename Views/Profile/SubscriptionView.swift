import SwiftUI

struct SubscriptionView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "star.fill").font(.system(size: 60)).foregroundColor(.yellow)
            Text("NurseTutor Premium").font(.largeTitle).fontWeight(.bold)
            Text("You are currently on the premium plan.").font(.subheadline).foregroundColor(.secondary)
            Button("Manage Subscription") {}.padding(.top, 20)
        }.padding().navigationTitle("Subscription")
    }
}

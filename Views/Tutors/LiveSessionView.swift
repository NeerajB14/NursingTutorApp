import SwiftUI

struct LiveSessionView: View {
    let tutor: Tutor
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Connecting to...").font(.subheadline).foregroundColor(.secondary)
            Text(tutor.name).font(.largeTitle).fontWeight(.bold)
            Image(systemName: "video.fill").font(.system(size: 80)).foregroundColor(.appPrimary).padding(40)
            ProgressView()
            Text("Your live session will begin shortly.").font(.caption).foregroundColor(.secondary).padding(.top)
        }.navigationTitle("Live Session")
    }
}

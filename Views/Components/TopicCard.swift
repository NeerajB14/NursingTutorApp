import SwiftUI

struct TopicCard: View {
    let topic: CourseTopic
    
    var body: some View {
        VStack {
            Image(systemName: topic.icon).font(.largeTitle).foregroundColor(Color.appPrimary)
            Text(topic.name).font(.caption).fontWeight(.semibold).multilineTextAlignment(.center)
        }.padding().frame(maxWidth: .infinity, minHeight: 100).background(Color.gray.opacity(0.1)).cornerRadius(15)
    }
}

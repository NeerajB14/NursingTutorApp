import SwiftUI

struct SectionView<Content: View, Destination: View>: View {
    let title: String
    let destination: Destination
    @ViewBuilder let content: Content

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(title).font(.title2).fontWeight(.bold)
                Spacer()
                NavigationLink("See All", destination: destination).foregroundColor(Color.appPrimary)
            }.padding(.bottom, 5)
            content
        }
    }
}

import SwiftUI

struct TutorDetailView: View {
    let tutor: Tutor

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    Image(systemName: "person.circle.fill").font(.system(size: 60)).foregroundColor(.gray)
                    VStack(alignment: .leading) {
                        Text(tutor.name).font(.title).fontWeight(.bold)
                        Text(tutor.specialty).font(.body).foregroundColor(.secondary)
                        HStack { Image(systemName: "star.fill").foregroundColor(.yellow); Text("\(tutor.rating, specifier: "%.1f")") }
                    }
                }.padding()
                Divider()
                VStack(alignment: .leading, spacing: 10) {
                    Text("About Me").font(.headline)
                    Text("Experienced clinical educator with over 10 years in critical care. Passionate about helping students master complex topics.").font(.body).lineSpacing(5)
                }.padding()
                VStack(alignment: .leading, spacing: 10) {
                    Text("Availability").font(.headline)
                    Text("Available Mon-Fri, 5 PM - 9 PM EST").padding().frame(maxWidth: .infinity).background(Color.gray.opacity(0.1)).cornerRadius(10)
                }.padding()
                Spacer()
                VStack(spacing: 15) {
                    NavigationLink(destination: LiveSessionView(tutor: tutor)) { Text("Start Instant Session").font(.headline).foregroundColor(.white).frame(maxWidth: .infinity).padding().background(Color.appSecondary).cornerRadius(10) }
                    NavigationLink(destination: SchedulingView(tutor: tutor)) { Text("Book a Future Session").font(.headline).foregroundColor(.white).frame(maxWidth: .infinity).padding().background(Color.appPrimary).cornerRadius(10) }
                }.padding()
            }
        }.navigationTitle("Tutor Profile").navigationBarTitleDisplayMode(.inline)
    }
}

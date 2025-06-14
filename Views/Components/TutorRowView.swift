import SwiftUI

struct TutorRowView: View {
    let tutor: Tutor
    
    var body: some View {
        HStack {
            Image(systemName: "person.crop.circle").font(.largeTitle).foregroundColor(.gray)
            VStack(alignment: .leading, spacing: 4) {
                Text(tutor.name).font(.headline)
                Text(tutor.specialty).font(.subheadline).foregroundColor(.secondary)
            }
            Spacer()
            HStack {
                Image(systemName: "star.fill").foregroundColor(.yellow)
                Text("\(tutor.rating, specifier: "%.1f")").font(.subheadline).foregroundColor(.secondary)
            }
        }.padding(.vertical, 8)
    }
}

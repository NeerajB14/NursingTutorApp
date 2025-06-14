import SwiftUI

struct BookmarksView: View {
    var body: some View {
        List {
            Label("Normal Potassium (K+)", systemImage: "bookmark.fill")
            Label("IV Insertion Technique", systemImage: "bookmark.fill")
        }.navigationTitle("Bookmarks")
    }
}

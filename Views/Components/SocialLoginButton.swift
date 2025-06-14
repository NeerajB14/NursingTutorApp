import SwiftUI

struct SocialLoginButton: View {
    let icon: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: icon).font(.title).foregroundColor(Color.appPrimary).frame(width: 60, height: 60).background(Color.gray.opacity(0.1)).clipShape(Circle())
        }
    }
}

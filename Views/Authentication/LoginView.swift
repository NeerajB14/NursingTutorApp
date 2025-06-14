import SwiftUI

struct LoginView: View {
    @Binding var isLoggedIn: Bool
    @State private var email = ""
    @State private var password = ""

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Spacer()
                Image(systemName: "cross.case.fill").font(.system(size: 60)).foregroundColor(Color.appPrimary)
                Text("NurseTutor").font(.largeTitle).fontWeight(.bold).foregroundColor(Color.appPrimary)
                Text("Your path to NCLEX success.").font(.subheadline).foregroundColor(.gray)
                VStack(spacing: 15) {
                    TextField("Email Address", text: $email).padding().background(Color.gray.opacity(0.1)).cornerRadius(10).keyboardType(.emailAddress).autocapitalization(.none)
                    SecureField("Password", text: $password).padding().background(Color.gray.opacity(0.1)).cornerRadius(10)
                }.padding(.horizontal)
                Button(action: { self.isLoggedIn = true }) {
                    Text("Sign In").font(.headline).foregroundColor(.white).frame(maxWidth: .infinity).padding().background(Color.appPrimary).cornerRadius(10)
                }.padding(.horizontal)
                VStack {
                    Text("or sign in with").foregroundColor(.gray)
                    HStack(spacing: 20) {
                        SocialLoginButton(icon: "apple.logo", action: { print("Apple Sign-In Tapped") })
                        SocialLoginButton(icon: "g.circle.fill", action: { print("Google Sign-In Tapped") })
                        SocialLoginButton(icon: "building.columns.fill", action: { print("School Sign-In Tapped") })
                    }
                }.padding(.top)
                Spacer()
                NavigationLink("Don't have an account? Sign Up", destination: SignUpView()).foregroundColor(Color.appPrimary)
            }.padding().background(Color.appBackground.edgesIgnoringSafeArea(.all)).navigationBarHidden(true)
        }
    }
}

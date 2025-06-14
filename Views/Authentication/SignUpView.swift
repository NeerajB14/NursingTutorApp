import SwiftUI

struct SignUpView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""

    var body: some View {
        VStack {
            Text("Create Account").font(.largeTitle).fontWeight(.bold).padding(.bottom, 40)
            VStack(spacing: 15) {
                TextField("Email Address", text: $email).padding().background(Color.gray.opacity(0.1)).cornerRadius(10)
                SecureField("Password", text: $password).padding().background(Color.gray.opacity(0.1)).cornerRadius(10)
                SecureField("Confirm Password", text: $confirmPassword).padding().background(Color.gray.opacity(0.1)).cornerRadius(10)
            }.padding(.horizontal)
            Button(action: {}) {
                Text("Sign Up").font(.headline).foregroundColor(.white).frame(maxWidth: .infinity).padding().background(Color.appPrimary).cornerRadius(10)
            }.padding()
            Spacer()
        }.padding().navigationTitle("Sign Up").navigationBarTitleDisplayMode(.inline)
    }
}

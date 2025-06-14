import SwiftUI

struct EditProfileView: View {
    @EnvironmentObject var userSession: UserSession
    @Environment(\.presentationMode) var presentationMode
    
    @State private var name: String
    @State private var school: String
    
    init() {
        _name = State(initialValue: "")
        _school = State(initialValue: "")
    }

    var body: some View {
        Form {
            Section(header: Text("Personal Information")) {
                TextField("Name", text: $name)
                TextField("School", text: $school)
            }
            Section {
                Button("Save Changes") {
                    userSession.name = self.name
                    userSession.school = self.school
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }.navigationTitle("Edit Profile")
        .onAppear {
            self.name = userSession.name
            self.school = userSession.school
        }
    }
}

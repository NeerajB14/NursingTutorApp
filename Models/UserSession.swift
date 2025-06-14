import Foundation

class UserSession: ObservableObject {
    @Published var name: String = "Casey Becker"
    @Published var school: String = "UCLA School of Nursing"
    @Published var joinDate: String = "October 2023"
    @Published var progress: Double = 75.0
}

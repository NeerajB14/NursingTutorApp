import SwiftUI

struct SchedulingView: View {
    let tutor: Tutor
    @State private var selectedDate = Date()
    
    var body: some View {
        Form {
            Section(header: Text("Book a session with \(tutor.name)")) {
                DatePicker("Select a Date", selection: $selectedDate, in: Date()..., displayedComponents: .date)
                DatePicker("Select a Time", selection: $selectedDate, in: Date()..., displayedComponents: .hourAndMinute)
            }
            Section { Button("Confirm Booking") {} }
        }.navigationTitle("Schedule Session")
    }
}

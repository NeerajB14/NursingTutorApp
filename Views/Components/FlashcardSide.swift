import SwiftUI

struct FlashcardSide: View {
    let text: String
    let color: Color
    
    var body: some View {
        VStack {
            Spacer()
            Text(text).font(.largeTitle).foregroundColor(.white).multilineTextAlignment(.center)
            Spacer()
        }.padding().frame(height: 300).frame(maxWidth: .infinity).background(color).cornerRadius(20).shadow(radius: 5)
    }
}

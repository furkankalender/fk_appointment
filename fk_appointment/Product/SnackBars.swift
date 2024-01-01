import SwiftUI

struct SuccessSnackbar: View {
    let text: String
    @Binding var isShowing: Bool

    var body: some View {
        VStack {
            Spacer()

            HStack {
                Spacer()

                Text(text)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(8)
                    .padding(.bottom, 8)
                    .onTapGesture {
                        isShowing = false
                    }
            }
        }
        .animation(.easeOut)
    }
}

import SwiftUI

struct ResetPasswordView: View {
    @StateObject private var viewModel = ResetPasswordViewModel()
    @State private var newPassword: String = ""

    var body: some View {
        VStack(spacing: 30) {
            Text("Reset Your Password")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.blue)

            TextField("Username", text: $viewModel.username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)

            SecureField("New Password", text: $newPassword)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Button(action: {
                viewModel.resetPassword(newPassword: newPassword)
            }) {
                Text("Reset Password")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.orange)
                    .cornerRadius(8)
            }
            .alert(viewModel.alertMessage, isPresented: $viewModel.showAlert) {
                Button("OK", role: .cancel) {}
            }
        }
        .padding()
    }
}

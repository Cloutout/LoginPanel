import SwiftUI

struct RegisterView: View {
    @StateObject private var viewModel = RegisterViewModel()
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 30) {
            Text("Create an Account")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.blue)

            TextField("Username", text: $viewModel.username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)

            SecureField("Password", text: $viewModel.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Button(action: {
                viewModel.register()
            }) {
                Text("Register")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.green)
                    .cornerRadius(8)
            }
            .alert(viewModel.alertMessage, isPresented: $viewModel.showAlert) {
                Button("OK") {
                    if viewModel.alertMessage == "Account created successfully!" {
                        dismiss()
                    }
                }
            }
        }
        .padding()
    }
}

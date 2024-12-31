import Foundation

class RegisterViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var alertMessage: String = ""
    @Published var showAlert: Bool = false

    func register() {
        guard let url = URL(string: "http://127.0.0.1:5000/signup") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: String] = ["username": username, "password": password]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)

        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.alertMessage = "Network error: \(error.localizedDescription)"
                    self.showAlert = true
                    return
                }

                guard let data = data else {
                    self.alertMessage = "No response from server."
                    self.showAlert = true
                    return
                }

                do {
                    let response = try JSONDecoder().decode(LoginResponse.self, from: data)
                    if response.success {
                        self.alertMessage = "Account created successfully!"
                    } else {
                        self.alertMessage = response.message
                    }
                    self.showAlert = true
                } catch {
                    self.alertMessage = "Invalid response from server."
                    self.showAlert = true
                }
            }
        }.resume()
    }
}

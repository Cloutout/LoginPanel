import Foundation

class LoginViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var isLoginSuccessful: Bool = false
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""

    func login() {
        guard let url = URL(string: "http://127.0.0.1:5000/login") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: String] = ["username": username, "password": password]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.errorMessage = "Network error: \(error.localizedDescription)"
                    self.showError = true
                    return
                }
                
                guard let data = data else {
                    self.errorMessage = "No response from server."
                    self.showError = true
                    return
                }
                
                do {
                    let response = try JSONDecoder().decode(LoginResponse.self, from: data)
                    if response.success {
                        self.isLoginSuccessful = true
                    } else {
                        self.errorMessage = response.message
                        self.showError = true
                    }
                } catch {
                    self.errorMessage = "Invalid response from server."
                    self.showError = true
                }
            }
        }.resume()
    }
}

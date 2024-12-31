import Foundation

class MainViewModel: ObservableObject {
    func logout() {
        UserDefaults.standard.removeObject(forKey: "authToken")
      
    }
}

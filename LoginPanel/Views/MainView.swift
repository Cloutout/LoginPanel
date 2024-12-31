import SwiftUI

struct MainView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var currentTime = Date()
    @State private var timer: Timer? = nil  // Timer'ı durdurabilmek için bir referans

    var body: some View {
        VStack(spacing: 20) {
            Text("Welcome to Your Dashboard!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.blue)

            ClockView(currentTime: $currentTime)

            Button("Logout") {
                timer?.invalidate()
                presentationMode.wrappedValue.dismiss()
            }
            .frame(maxWidth: .infinity)
            .padding()
            .foregroundColor(.white)
            .background(Color.red)
            .cornerRadius(8)
            .padding(.top, 20)
        }
        .padding()
        .onAppear {
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                self.currentTime = Date()
            }
        }
        .onDisappear {
            timer?.invalidate()
        }
    }
}

struct ClockView: View {
    @Binding var currentTime: Date

    var body: some View {
        VStack {
            Text("Digital Clock")
                .font(.title2)

            Text(DateFormatter.localizedString(from: currentTime, dateStyle: .none, timeStyle: .medium))
                .font(.system(size: 32, weight: .bold, design: .monospaced))
                .foregroundColor(.gray)
        }
    }
}

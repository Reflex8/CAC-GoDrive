//
import SwiftUI
import CoreHaptics
import FirebaseAuth
import GoogleSignIn
import Firebase

public struct DraggingComponent: View {

    @Binding var isLocked: Bool
    let isLoading: Bool
    let maxWidth: CGFloat

    @State private var width = CGFloat(90)
    private  let minWidth = CGFloat(90)

    public init(isLocked: Binding<Bool>, isLoading: Bool, maxWidth: CGFloat) {
        _isLocked = isLocked
        self.isLoading = isLoading
        self.maxWidth = maxWidth
    }

    public var body: some View {
        RoundedRectangle(cornerRadius: 26)
            .fill(Color(#colorLiteral(red: 0.4470587969, green: 0.4470587969, blue: 0.4470588565, alpha: 1)))
            .opacity(width / maxWidth)
            .frame(width: width)
            .overlay(
                Button(action: { }) {
                    ZStack {
                        image(name: "bolt.fill", isShown: isLocked)
                        progressView(isShown: isLoading)
                        image(name: "bolt", isShown: !isLocked && !isLoading)
                    }
                    .animation(.easeIn(duration: 0.35).delay(0.55), value: !isLocked && !isLoading)
                    
                }
                .buttonStyle(BaseButtonStyle())
                .disabled(!isLocked || isLoading),
                alignment: .trailing
            )

            .simultaneousGesture(
                DragGesture()
                    .onChanged { value in
                        guard isLocked else { return }
                    if value.translation.width > 0 {
                        width = min(max(value.translation.width + minWidth, minWidth), maxWidth)
                    }
                    }
                    .onEnded { value in
                        guard isLocked else { return }
                        if width < maxWidth {
                            width = minWidth
                            UINotificationFeedbackGenerator().notificationOccurred(.warning)
                        } else {
                            UINotificationFeedbackGenerator().notificationOccurred(.success)
                            onFullProgress()
                            withAnimation(.spring().delay(0.5)) {
                                isLocked = false
                            }
                        }
                    }
            )
            .animation(.spring(response: 0.5, dampingFraction: 1, blendDuration: 0), value: width)

    }

    private func image(name: String, isShown: Bool) -> some View {
        Image(systemName: name)
            .font(.system(size: 15, weight: .regular, design: .rounded))
            .foregroundColor(Color.white)
            .frame(width:80,height:80)
            .background(RoundedRectangle(cornerRadius: 26).fill(Color(#colorLiteral(red: 0.4470587969, green: 0.4470587969, blue: 0.4470588565, alpha: 1))))
            .padding(4)
            .opacity(isShown ? 1 : 0)
            .scaleEffect(isShown ? 1 : 0.01)
    }

    private func progressView(isShown: Bool) -> some View {
        ProgressView()
            .progressViewStyle(.circular)
            .tint(.white)
            .opacity(isShown ? 1 : 0)
            .scaleEffect(isShown ? 1 : 0.01)
    }

    
    private func onFullProgress() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
                            let config = GIDConfiguration(clientID: clientID)
        
                            GIDSignIn.sharedInstance.configuration = config
        
                            GIDSignIn.sharedInstance.signIn(withPresenting: getRootViewController()) { signResult, error in
        
                                if let error = error {
                                    //...
                                    return
                                }
        
                                guard let user = signResult?.user,
                                      let idToken = user.idToken else { return }
        
                                let accessToken = user.accessToken
        
                                let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString, accessToken: accessToken.tokenString)
        
                                // Use the credential to authenticate with Firebase
        
                                Auth.auth().signIn(with: credential) { signResult, error in
                                    guard error == nil else {
                                        return
                                    }
                                    guard let userID = signResult?.user.uid else { return }
                                    print(userID)
        
                                    print("SIGN IN")
                                    UserDefaults.standard.set(true, forKey: "signIn")
                                }
        
                            }
        }
}


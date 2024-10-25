import SwiftUI
import GoogleSignIn
import SDWebImageSwiftUI
import FirebaseAuth

extension View {
    func glow(color: Color = Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)), radius: CGFloat = 40) -> some View {
        self
            .shadow(color: color.opacity(0.8), radius: radius / 3)
            .shadow(color: color, radius: radius / 3)
            .shadow(color: color, radius: radius / 3)
    }
    
    func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            return AnyView(transform(self))
        } else {
            return AnyView(self)
        }
    }
}

struct ProfileView: View {
    @State private var user: User? = Auth.auth().currentUser
    @State private var isGlowing = false
    @State private var counter = 0
    
    var body: some View {
        VStack {
            if let user = user {
                if let profilePicUrl = user.photoURL {
                    WebImage(url: profilePicUrl)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                }
                
                Text("\(user.displayName ?? "User")")
                    .font(.custom("YoungSerif-Regular", size: 23))
                    .padding()
                
                ZStack {
                    Capsule()
                        .fill(Color(#colorLiteral(red: 0.1568627059, green: 0.1568627059, blue: 0.1568627059, alpha: 1)))
                        .frame(width: 200, height: 80)
                    
                    HStack {
                        Circle()
                            .fill(Color(#colorLiteral(red: 0.2274509966, green: 0.2274509966, blue: 0.2274509966, alpha: 1)))
                            .frame(width: 70, height: 70)
                            .overlay(
                                Text("\(counter)")
                                    .foregroundColor(Color.white)
                                    .font(.title)
                            )
                    }
                }
                .padding(.bottom, 50)
                
                Button(action: {
                    withAnimation {
                        isGlowing.toggle()
                    }
                    if isGlowing {
                        counter += 1
                    } else {
                        counter -= 1
                    }
                }) {
                    ZStack {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 300, height: 300)
                            .if(isGlowing) { view in
                                view.glow()
                            }
                        
                        Image(systemName: "bolt.fill")
                            .font(.system(size: 150))
                            .foregroundColor(Color(#colorLiteral(red: 0.275247246, green: 0.739964366, blue: 0.8423855305, alpha: 1)))
                    }
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

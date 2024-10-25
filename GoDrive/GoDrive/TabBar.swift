


import SwiftUI


class MyModel: ObservableObject {
    @Published var selectedHome: Bool = true
    @Published var selectedMap: Bool = false
    @Published var selectedProfile: Bool = false

    
    func toHome() {
        selectedHome = true
        selectedMap = false
        selectedProfile = false
    }
    
    func toMap() {
        selectedHome = false
        selectedMap = true
        selectedProfile = false
    }
    
    func toProfile() {
        selectedHome = false
        selectedMap = false
        selectedProfile = true
    }
}



enum Tabs: Int {
    case home = 0
    case map = 1
    case profile = 2
    
}

struct TabBar: View {
    @State private var selectedTab: Tabs = .home
    @EnvironmentObject var viewModel: tabModel
    
    var body: some View {
        VStack {
            ZStack {
                BlurView(style: .systemUltraThinMaterial)
                    .frame(height: 49)
                    .frame(maxWidth: .infinity)
                    .cornerRadius(25)
                    .padding(.horizontal, 14)
                
                HStack(alignment:.center) {
                    Spacer()
                    //MARK: Home
                    Group{
                        ZStack{
                            if selectedTab == .home {
                                indicator()
                            }
                            Button {
                                selectedTab = .home
                                viewModel.selectedTab = "home"
                            } label: {
                                Image(systemName: "house")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 24, height: 24)
                                    .opacity(selectedTab == .home ? 1 : 0.5)
                            }
                        }
                        Spacer()
                    }
                    
                    //MARK: Map
                    Group{
                        ZStack{
                            if selectedTab == .map {
                                indicator()
                            }
                            Button {
                                selectedTab = .map
                                viewModel.selectedTab = "map"
                            } label: {
                                Image(systemName: "map")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 24, height: 24)
                                    .opacity(selectedTab == .map ? 1 : 0.5)
                            }
                        }
                        Spacer()
                    }
                    
                    //MARK: Profile
                    Group{
                        ZStack{
                            if selectedTab == .profile {
                                indicator()
                            }
                            Button {
                                selectedTab = .profile
                                viewModel.selectedTab = "profile"
                            } label: {
                                Image(systemName: "person.crop.circle")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 24, height: 24)
                                    .opacity(selectedTab == .profile ? 1 : 0.5)
                            }
                        }
                        Spacer()
                    }
                }
            }
        }
        .padding()
    }
}






struct indicator: View {
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .foregroundColor(.blue)
            .frame(width: 25, height: 5)
            .offset(y: -18)
    }
}



struct BlurView: UIViewRepresentable {
    
    let style: UIBlurEffect.Style
    
    func makeUIView(context: UIViewRepresentableContext<BlurView>) -> UIView {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        let blurEffect = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(blurView, at: 0)
        NSLayoutConstraint.activate([
            blurView.heightAnchor.constraint(equalTo: view.heightAnchor),
            blurView.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
        return view
    }
    
    func updateUIView(_ uiView: UIView,
                      context: UIViewRepresentableContext<BlurView>) {
    }
}

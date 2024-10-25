//
//
//  Created by Rajeev Kumar on 6/30/24.
//

import SwiftUI
import Firebase

@main
struct GoDriveApp: App {
    @AppStorage("signIn") var isSignIn = false
    
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            if !isSignIn {
                LoginScreen()
            } else {
                ContentView()
                    .environmentObject(tabModel())
            }
        }
    }
}

//
//  AuthViewModel.swift
//


import Foundation
import FirebaseAuth

class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    
    init(){
        self.userSession = Auth.auth().currentUser
        
        print("DEBUH: User seession is \(self.userSession)")
    }
}

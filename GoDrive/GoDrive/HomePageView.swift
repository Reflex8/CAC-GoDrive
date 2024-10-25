//
//  HomePageView.swift
//  Nav App
//
//  Created by Ayush Malpani on 10/22/24.
//

import SwiftUI
import FirebaseAuth

struct HomePageView: View {
    @State private var user: User? = Auth.auth().currentUser

    var body: some View {
            VStack(spacing: 20) {
                HStack {
                    VStack(alignment: .leading) {
                        if let user = user{
                            
                            Text("Hi \(user.displayName ?? "User")! 👋")
                                .font(.system(size: 28, weight: .bold))
                        }
                        Text("Where will we go today?")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    Menu {
                        Button(action: {
                            let firebaseAuth = Auth.auth()
                            do {
                                try firebaseAuth.signOut()
                                UserDefaults.standard.set(false, forKey: "signIn")
                            } catch let signOutError as NSError {
                                print("Error signing out: %@", signOutError)
                            }
                        }) {
                            Text("Sign Out")
                            Image(systemName: "rectangle.portrait.and.arrow.right")
                        }
                    } label: {
                        Label {
                            
                        } icon: {
                            Image(systemName: "person.crop.circle")
                                .font(.largeTitle)
                                .foregroundColor(.blue)
                        }
                    }

                }
                .padding(.horizontal)
                .padding(.top, 40)

                Button(action: {}) {
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Text("Graham Ave")
                                .font(.system(size: 20, weight: .medium))
                                .foregroundColor(.white)
                            Spacer()
                            Image(systemName: "map.fill")
                                .font(.title)
                                .foregroundColor(.white)
                        }
                        Text("Patterson, St")
                            .font(.system(size: 14, weight: .light))
                            .foregroundColor(.white.opacity(0.8))

                        Spacer()

                        HStack {
                            Text("4.3 Mile")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.white)
                            Spacer()
                            Text("62 Min")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.white)
                        }
                    }
                    .padding()
                    .frame(height: 150)
                    .background(
                        Color(#colorLiteral(red: 0.1418370154, green: 0.1418370154, blue: 0.1418370154, alpha: 1))
                    )
                    .cornerRadius(20)
                    
                }
                .buttonStyle(PlainButtonStyle())
                .padding(.horizontal)

              
Spacer()
                HStack(spacing: 15) {
                    Button(action: {}) {
                        VStack(spacing: 8) {
                            Image(systemName: "clock.fill")
                                .font(.largeTitle)
                                .foregroundColor(.blue)
                            Text("Time Saved")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.gray)
                            Text("10 Min")
                                .font(.system(size: 28, weight: .bold))
                                .foregroundColor(.black)
                            Text("in Traffic")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.gray)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(20)
                        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
                    }

                    Button(action: {}) {
                        VStack(spacing: 8) {
                            Image(systemName: "location.fill")
                                .font(.largeTitle)
                                .foregroundColor(.red)
                            Text("Past Routes")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.gray)
                            Text("7")
                                .font(.system(size: 28, weight: .bold))
                                .foregroundColor(.black)
                            Text("Trips Logged")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.gray)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(20)
                        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
                    }
                }
                .padding(.horizontal)
Spacer()
                HStack(spacing: 15) {
                    ForEach(["Car Crashes Near You", "Safety Score", "Traffic Lights Passed", "Perfect Traffic Lights"], id: \.self) { stat in
                        Button(action: {}) {
                            VStack(spacing: 8) {
                                Text(stat)
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(.white.opacity(0.8))
                                Text("152")
                                    .font(.system(size: 22, weight: .bold))
                                    .foregroundColor(.white)
                            }
                            .frame(width: 80, height: 120)
                            .background(
                                Color(#colorLiteral(red: 0.4735028731, green: 0.7888345608, blue: 1, alpha: 1))
                            )
                            .cornerRadius(20)
                            .shadow(color: Color.green.opacity(0.3), radius: 10, x: 0, y: 5)
                        }
                    }
                }
            }
        
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}

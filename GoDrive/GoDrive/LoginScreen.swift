//
//  LoginScreen.swift
//  GoDrive
//
//  Created by Rithik K on 10/15/24.
//


import SwiftUI

struct LoginScreen: View {
    @State private var isLocked = true
       @State private var isLoading = false
    var body: some View {
        ZStack{
            Image("aleksei-sabulevskii-WWL_6yW4274-unsplash")
                            .resizable()
                            .scaledToFill() 
                            .ignoresSafeArea()
        VStack {
            
            HStack{
                Spacer()
                Text("GoDrive")
                    .font(.custom("PlaywriteIS-Regular", size: 46))
                    .foregroundStyle(Color.white)
                Image(systemName: "bolt.fill")
                    .foregroundStyle(Color(#colorLiteral(red: 0.7238066792, green: 0.9971416593, blue: 0.9999756217, alpha: 1)))
                Spacer()
            }
            .padding(.top, 20)
            Spacer()
            (Text("MAKE YOUR\n")
                    + Text("DRIVING").foregroundColor(Color(#colorLiteral(red: 0.7238066792, green: 0.9971416593, blue: 0.9999756217, alpha: 1)))
                    + Text(" SMARTER\nAND EASIER."))
            .font(.system(size:30))
            .bold()
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
            
            //MARK: SIGN IN SLIDER
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    BackgroundComponent()
                    DraggingComponent(isLocked: $isLocked, isLoading: isLoading, maxWidth: geometry.size.width)
                }
            }
            .frame(height: 90)
            .onChange(of: isLocked) { isLocked in
                guard !isLocked else { return }
                simulateRequest()
            }
        }
        .padding()
            
    }
        
    
    }
    private func simulateRequest() {
            isLoading = true

            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                isLoading = false
            }
        }
}




#Preview {
    LoginScreen()
}

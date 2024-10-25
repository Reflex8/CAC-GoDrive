//
//  GoogleSiginBtn.swift
//
//  Created by Rajeev Kumar on 8/26/24.
//

import SwiftUI

struct GoogleSiginBtn: View {
    var action: () -> Void
    var body: some View {
        Button {
            action()
        } label: {
            ZStack{
                Circle()
                    .foregroundColor(.white)
                    .shadow(color: .gray, radius: 4, x: 0, y: 2)
                Image("GoogleLogo")
                    .resizable()
                    .scaledToFit()
                    .padding(8)
                    .mask(
                        Circle()
                    )
            }
        }
    }
}

struct GoogleSiginBtn_Previews: PreviewProvider {
    static var previews: some View {
        GoogleSiginBtn(action: {})
    }
}

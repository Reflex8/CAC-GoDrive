//


import SwiftUI

public struct BackgroundComponent: View {

    @State private var hueRotation = false

    public init() { }

    public var body: some View {
        ZStack(alignment: .leading)  {
     
            RoundedRectangle(cornerRadius: 28)
                .fill(Color(#colorLiteral(red: 0.4470587969, green: 0.4470587969, blue: 0.4470588565, alpha: 0.7478564938)))
                .hueRotation(.degrees(hueRotation ? 20 : -20))

            Text("Start Driving")
                .font(.system(size:20))
                .bold()
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
            
            Image(systemName: "chevron.right")
                .foregroundStyle(Color.white)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(16)
        
        }
        .onAppear {
            withAnimation(.linear(duration: 3).repeatForever(autoreverses: true)) {
                hueRotation.toggle()
            }
        }
    }

}










  

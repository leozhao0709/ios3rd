//
//  MenuView.swift
//  DesignCode
//
//  Created by Lei Zhao on 5/3/21.
//
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        VStack {
            Spacer()

            VStack(spacing: 16) {
                Text("Meng - 28% complete")
                  .font(.caption)

                Color.white
                  .frame(width: 38, height: 6)
                  .cornerRadius(3)
                  .frame(width: 130, height: 6, alignment: .leading)
                  .background(Color.black.opacity(0.08))
                  .cornerRadius(3)
                  .padding()
                  .frame(width: 150, height: 24)
                  .background(Color.black.opacity(0.1))
                  .cornerRadius(12)

                MenuRow(title: "Account", icon: "gear")
                MenuRow(title: "Billing", icon: "creditcard")
                MenuRow(title: "Sign out", icon: "person.crop.circle")
            }
              .frame(maxWidth: .infinity)
              .frame(height: 300)
              .background(LinearGradient(gradient: Gradient(colors: [.white, Color(#colorLiteral(red: 0.8705882353, green: 0.8941176471, blue: 0.9450980392, alpha: 1))]), startPoint: .top, endPoint: .bottom))
              .cornerRadius(30)
              .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
              .padding(.horizontal, 30)
              .overlay(
                Image("Avatar")
                  .resizable()
                  .frame(width: 60, height: 60)
                  .clipShape(Circle())
                  .offset(y: -150)
              )
        }
          .padding(.bottom, 30)
    }
}

class MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }

    #if DEBUG
        @objc class func injected() {
            UIApplication.shared.windows.first?.rootViewController =
              UIHostingController(rootView: MenuView_Previews.previews)
        }
    #endif
}

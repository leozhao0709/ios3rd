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
                MenuRow(title: "Account", icon: "gear")
                MenuRow(title: "Billing", icon: "creditcard")
                MenuRow(title: "Sign out", icon: "person.crop.circle")
            }
              .frame(maxWidth: .infinity)
              .frame(height: 300)
              .background(LinearGradient(gradient: Gradient(colors: [.white, Color(UIColor(named: "DEE4F1")!)]), startPoint: .top, endPoint: .bottom))
              .cornerRadius(30)
              .shadow(radius: 30)
              .padding(.horizontal, 30)
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

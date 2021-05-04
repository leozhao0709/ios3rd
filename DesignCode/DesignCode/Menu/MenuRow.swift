//
//  MenuRow.swift
//  DesignCode
//
//  Created by Lei Zhao on 5/3/21.
//
//

import SwiftUI

struct MenuRow: View {
    var title: String = "Account"
    var icon: String = "gear"

    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
              .font(.system(size: 20, weight: .light))
              .imageScale(.large)
              .frame(width: 32, height: 32)
                .foregroundColor(Color(#colorLiteral(red: 0.662745098, green: 0.7333333333, blue: 0.831372549, alpha: 1)))
            Text(title)
              .font(.system(size: 20, weight: .bold, design: .default))
              .frame(width: 120, alignment: .leading)
        }
    }
}

class MenuRow_Previews: PreviewProvider {
    static var previews: some View {
        MenuRow()
    }

    #if DEBUG
    @objc class func injected() {
        UIApplication.shared.windows.first?.rootViewController =
          UIHostingController(rootView: MenuRow_Previews.previews)
    }
    #endif
}

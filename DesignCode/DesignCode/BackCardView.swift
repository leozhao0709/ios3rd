//
//  BackCardView.swift
//  DesignCode
//
//  Created by Lei Zhao on 5/2/21.
//
//

import SwiftUI

struct BackCardView: View {
    var color: Color = Color.blue

    var body: some View {
        Rectangle()
          .fill(color)
          .frame(width: 300, height: 220)
          .cornerRadius(20)
          .shadow(radius: 20)
    }
}

class BackCardView_Previews: PreviewProvider {
    static var previews: some View {
        BackCardView(color: Color.blue)
    }

    #if DEBUG
        @objc class func injected() {
            UIApplication.shared.windows.first?.rootViewController =
              UIHostingController(rootView: BackCardView_Previews.previews)
        }
    #endif
}

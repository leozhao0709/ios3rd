//
//  BottomCardView.swift
//  DesignCode
//
//  Created by Lei Zhao on 5/2/21.
//
//

import SwiftUI

struct BottomCardView: View {

    var body: some View {
        VStack(spacing: 20) {
            Rectangle()
              .frame(width: 40, height: 5)
              .cornerRadius(3)
              .opacity(0.1)
            Text("This certificate is proof that Meng To has achieved the UI Design course with approval from a Design+Code instructor.")
              .multilineTextAlignment(.center)
              .font(.subheadline)
              .lineSpacing(4)
            Spacer()
        }
          .padding(.top, 8)
          .padding(.horizontal, 20)
          .frame(maxWidth: .infinity)
          .background(Color.white)
          .cornerRadius(30)
          .shadow(radius: 20)
    }
}

class BottomCardView_Previews: PreviewProvider {
    static var previews: some View {
        BottomCardView()
    }

    #if DEBUG
        @objc class func injected() {
            UIApplication.shared.windows.first?.rootViewController =
              UIHostingController(rootView: BottomCardView_Previews.previews)
        }
    #endif
}

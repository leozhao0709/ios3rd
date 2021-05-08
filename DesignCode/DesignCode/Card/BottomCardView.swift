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
            HStack(spacing: 20) {
                RingView(color1: Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)), color2: Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)), width: 88, height: 88, percent: 78)

                VStack(alignment: .leading, spacing: 8) {
                    Text("SwiftUI").fontWeight(.bold)
                    Text("12 of 12 sections completed\n10 hours spent so far")
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .lineSpacing(4)
                }
                    .padding(20)
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(color: Color.black.opacity(0.2), radius: 20, y: 10)
            }
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

//
//  CardView.swift
//  DesignCode
//
//  Created by Lei Zhao on 5/2/21.
//
//

import SwiftUI

struct CardView: View {
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("UI Design")
                      .font(.title)
                      .fontWeight(.semibold)
                      .foregroundColor(.white)
                    Text("Certificate")
                      .foregroundColor(Color("accent"))
                }
                Spacer()
                Image("Logo1")
            }
              .padding(20)
            Image("Card1")
              .resizable()
              .aspectRatio(contentMode: .fill)
              .frame(width: 300, height: 110, alignment: .top)
        }
          .frame(width: 340.0, height: 220.0)
          .background(Color.black)
          .cornerRadius(20)
          .shadow(radius: 20)
    }
}

class CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }

    #if DEBUG
        @objc class func injected() {
            UIApplication.shared.windows.first?.rootViewController =
              UIHostingController(rootView: CardView_Previews.previews)
        }
    #endif
}

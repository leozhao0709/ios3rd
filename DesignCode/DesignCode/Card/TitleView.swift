//
//  TitleView.swift
//  DesignCode
//
//  Created by Lei Zhao on 5/2/21.
//
//

import SwiftUI

struct TitleView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Certificates")
                  .font(.largeTitle)
                  .fontWeight(.bold)
                Spacer()
            }
              .padding()
            Image("Background1")
            Spacer()
        }
    }
}

class TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView()
    }

    #if DEBUG
        @objc class func injected() {
            UIApplication.shared.windows.first?.rootViewController =
              UIHostingController(rootView: TitleView_Previews.previews)
        }
    #endif
}

//
//  AvatarView.swift
//  DesignCode
//
//  Created by Lei Zhao on 5/4/21.
//
//

import SwiftUI

struct AvatarView: View {
    @Binding var showProfile: Bool

    var body: some View {
        Button(action: { showProfile.toggle() }, label: {
            Image("Avatar")
              .resizable()
              .frame(width: 36, height: 36)
              .clipShape(Circle())
        })
    }
}

class AvatarView_Previews: PreviewProvider {
    static var previews: some View {
        AvatarView(showProfile: .constant(false))
    }

    #if DEBUG
        @objc class func injected() {
            UIApplication.shared.windows.first?.rootViewController =
              UIHostingController(rootView: AvatarView_Previews.previews)
        }
    #endif
}

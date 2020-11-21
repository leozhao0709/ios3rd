//
//  FormLabelView.swift
//  HypedList
//
//  Created by Lei Zhao on 11/20/20.
//

import SwiftUI

struct FormLabelView: View {

    var title: String
    var imageName: String
    var iconColor = Color.blue

    var body: some View {
        Label(
          title: { Text(title) },
          icon: {
              Image(systemName: imageName)
                .padding(4)
                .background(iconColor)
                .cornerRadius(7)
                .foregroundColor(.white)
          }
        )
    }
}

class FormLabelView_Previews: PreviewProvider {
    static var previews: some View {
        FormLabelView(title: "Title", imageName: "keyboard")
    }

    #if DEBUG
        @objc class func injected() {
            UIApplication.shared.windows.first?.rootViewController =
              UIHostingController(rootView: FormLabelView_Previews.previews)
        }
    #endif
}

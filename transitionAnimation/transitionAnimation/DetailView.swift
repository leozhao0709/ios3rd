//
//  DetailView.swift
//  transitionAnimation
//
//  Created by Lei Zhao on 11/8/20.
//
//

import SwiftUI

struct DetailView: View {
    var body: some View {
        Image("iPhone11")
    }
}

class DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }

    #if DEBUG
        @objc class func injected() {
            UIApplication.shared.windows.first?.rootViewController =
              UIHostingController(rootView: DetailView_Previews.previews)
        }
    #endif
}
//
//  SubView.swift
//  onBoardScreen
//
//  Created by Lei Zhao on 10/31/20.
//
//

import SwiftUI

struct SubView: View {
    var imageString: String

    var body: some View {
        VStack {
            Image(imageString)
              .resizable()
              .scaledToFit()
        }.background(Color.red)
    }
}


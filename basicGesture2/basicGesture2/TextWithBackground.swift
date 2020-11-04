//
//  TextWithBackground.swift
//  gestureTest
//
//  Created by Lei Zhao on 11/2/20.
//
//

import SwiftUI

struct TextWithBackground: View {

    var text: String

    init(_ text: String) {
        self.text = text
    }

    var body: some View {
        Text(self.text)
          .font(.largeTitle)
          .padding()
          .background(Color.green)
    }
}

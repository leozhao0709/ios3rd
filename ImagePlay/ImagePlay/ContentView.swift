//
//  ContentView.swift
//  ImagePlay
//
//  Created by Lei Zhao on 11/13/20.
//
//

import SwiftUI
import SDWebImageSwiftUI

struct ContentView: View {
    var body: some View {
        AnimatedImage(url: Bundle.main.url(forResource: "giphy.gif", withExtension: nil))
            .frame(width: 300, height: 200)
        Text("12345")
    }
}

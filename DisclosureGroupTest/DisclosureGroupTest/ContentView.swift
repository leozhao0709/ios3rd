//
//  ContentView.swift
//  DisclosureGroupTest
//
//  Created by Lei Zhao on 11/22/20.
//
//

import SwiftUI

struct ContentView: View {

    @State private var animalsExpanded = true
    let animals = ["🦒", "🐿", "🐆"];

    var body: some View {
        DisclosureGroup(isExpanded: $animalsExpanded, content: {
            HStack {
                ForEach(animals, id: \.self) {
                    Text($0)
                      .font(.title)
                }
            }
        }) {
            Text("Animals")
        }.fixedSize()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

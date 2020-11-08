//
//  ContentView.swift
//  lazyGrid
//
//  Created by Lei Zhao on 11/7/20.
//
//

import SwiftUI

struct ContentView: View {
    let data = (1...1000).map {
        "Item \($0)"
    }

    let columns = [
        GridItem(.adaptive(minimum: 80))
//        GridItem(.flexible())
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(data, id: \.self) { item in
                    Text(item)
                }
            }
              .padding(.horizontal)
        }
    }

//    let items = 1...10
//
//    let rows = [
//        GridItem(.adaptive(minimum: 200)),
//    ]
//
//    var body: some View {
//        ScrollView(.horizontal) {
//            LazyHGrid(rows: rows) {
//                ForEach(items, id: \.self) { item in
//                    Text("Heading\(item)")
//                }
//            }
//        }
//    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

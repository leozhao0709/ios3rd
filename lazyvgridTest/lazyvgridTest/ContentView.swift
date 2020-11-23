//
//  ContentView.swift
//  lazyvgridTest
//
//  Created by Lei Zhao on 11/22/20.
//

import SwiftUI

struct ContentView: View {
    
    let columns = [
        GridItem(.adaptive(minimum: 80))
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, pinnedViews: [.sectionHeaders]){
                    Section(header: Text("Section 1"), content: {
                        ForEach(0...100, id: \.self) { index in
                            Text("\(index)")
                        }
                    })
                    
                    Section(header: Text("Section 2"), content: {
                        ForEach(101...200, id: \.self) { index in
                            Text("\(index)")
                        }
                    })
                }
            }.navigationTitle(Text("test"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

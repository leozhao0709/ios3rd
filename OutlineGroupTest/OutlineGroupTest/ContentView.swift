//
//  ContentView.swift
//  OutlineGroupTest
//
//  Created by Lei Zhao on 11/22/20.
//
//

import SwiftUI

struct FileItem: Identifiable {
    var id: UUID = UUID()
    var name: String
    var items: [FileItem]? = nil
}

struct ContentView: View {
    let fileItems = [
        FileItem(name: "users1", items:
        [FileItem(name: "user1234", items:
        [FileItem(name: "Photos", items:
        [FileItem(name: "photo001.jpg"),
         FileItem(name: "photo002.jpg")]),
            FileItem(name: "Movies", items:
            [FileItem(name: "movie001.mp4")]),
            FileItem(name: "Documents", items: [])
        ]),
            FileItem(name: "newuser", items:
            [FileItem(name: "Documents", items: [])
            ])
        ]),
        FileItem(name: "users2", items:
        [FileItem(name: "user1234", items:
        [FileItem(name: "Photos", items: [])
        ])
        ]),
    ]

    var body: some View {
        List {
            ForEach(fileItems) { fileItem in
                OutlineGroup(fileItem, children: \.items) { item in
                    Text("\(item.name)")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

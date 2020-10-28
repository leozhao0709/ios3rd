//
//  MovieMemoApp.swift
//  MovieMemo
//
//  Created by Lei Zhao on 10/27/20.
//

import SwiftUI

@main
struct MovieMemoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

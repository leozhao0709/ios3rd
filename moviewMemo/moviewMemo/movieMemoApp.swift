//
//  moviewMemoApp.swift
//  moviewMemo
//
//  Created by Lei Zhao on 10/27/20.
//

import SwiftUI

@main
struct movieMemoApp: App {
  let persistenceController = PersistenceController.shared

  var body: some Scene {
    WindowGroup {
      ContentView()
        .environment(\.managedObjectContext, persistenceController.container.viewContext)
    }
  }

  init() {
    loadInjectionIIIInDebug()
  }

  func loadInjectionIIIInDebug() {
    #if DEBUG
      var injectionBundlePath = "/Applications/InjectionIII.app/Contents/Resources"
      #if targetEnvironment(macCatalyst)
        injectionBundlePath = "\(injectionBundlePath)/macOSInjection.bundle"
      #elseif os(iOS)
        injectionBundlePath = "\(injectionBundlePath)/iOSInjection.bundle"
      #endif
      Bundle(path: injectionBundlePath)?.load()
    #endif
  }
}

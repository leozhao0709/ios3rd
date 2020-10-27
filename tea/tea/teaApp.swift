//
//  teaApp.swift
//  tea
//
//  Created by Lei Zhao on 10/26/20.
//
//

import SwiftUI

@main
struct teaApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(PublishedOrder())
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

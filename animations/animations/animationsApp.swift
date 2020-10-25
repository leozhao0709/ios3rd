//
//  animationsApp.swift
//  animations
//
//  Created by Lei Zhao on 10/24/20.
//
//

import SwiftUI

@main
struct animationsApp: App {

    init() {
        loadInjectionIIIInDebug()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
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

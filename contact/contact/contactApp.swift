//
//  contactApp.swift
//  contact
//
//  Created by Lei Zhao on 10/31/20.
//
//

import SwiftUI

@main
struct contactApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
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

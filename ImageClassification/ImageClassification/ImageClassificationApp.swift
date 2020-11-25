//
//  ImageClassificationApp.swift
//  ImageClassification
//
//  Created by Lei Zhao on 11/24/20.
//
//

import SwiftUI

@main
struct ImageClassificationApp: App {
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

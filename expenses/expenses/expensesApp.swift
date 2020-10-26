//
//  expensesApp.swift
//  expenses
//
//  Created by Lei Zhao on 10/25/20.
//
//

import SwiftUI

@main
struct expensesApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(Expense())
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

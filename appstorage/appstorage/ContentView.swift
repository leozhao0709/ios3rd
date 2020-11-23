//
//  ContentView.swift
//  appstorage
//
//  Created by Lei Zhao on 11/22/20.
//
//

import SwiftUI

struct ContentView: View {

    @AppStorage("isDarkMode") private var isDarkMode = false

    var body: some View {
        Text(isDarkMode ? "Dark" : "Light")
        Toggle(isOn: $isDarkMode) {
            Text("Select Mode")
        }.fixedSize()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

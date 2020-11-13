//
//  ContentView.swift
//  audioPlay
//
//  Created by Lei Zhao on 11/13/20.
//
//

import SwiftUI

struct ContentView: View {

    let audioManager = AudioManager.sharedInstance

    var body: some View {
        VStack(spacing: 20) {
            Button("震动") {
                audioManager.playVibrateSound { error in
                    print("...error...\(error.localizedDescription)")
                }
            }

            Button("系统声音") {
                audioManager.playSystemSound { print("...finish system sound...") }
            }

            Button("提示音") {
            }
        }
    }
}


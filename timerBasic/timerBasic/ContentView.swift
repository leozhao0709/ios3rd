//
//  ContentView.swift
//  timerBasic
//
//  Created by Lei Zhao on 11/2/20.
//
//

import SwiftUI

struct ContentView: View {

    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    //添加tolerance(容差值)提升App性能
    let timer2 = Timer.publish(every: 1, tolerance: 0.5, on: .main, in: .common)

    @State(initialValue: 0) private var counter

    var body: some View {
        Text("Hello, world!")
            .onReceive(timer) { time in
                if self.counter == 5 {
                    self.timer.upstream.connect().cancel()
                    return
                }
                print(time)
                self.counter += 1
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

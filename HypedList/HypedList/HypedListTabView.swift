//
//  ContentView.swift
//  HypedList
//
//  Created by Lei Zhao on 11/19/20.
//

import SwiftUI

struct HypedListTabView: View {
    var body: some View {
        TabView {
            UpcomingView()
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Upcoming")
                }
            Text("Discover")
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Discover")
                }
            Text("Past")
                .tabItem {
                    Image(systemName: "gobackward")
                    Text("Past")
                }
        }
    }
}

class HypedListTabView_Previews: PreviewProvider {
    static var previews: some View {
        HypedListTabView()
    }

    #if DEBUG
        @objc class func injected() {
            UIApplication.shared.windows.first?.rootViewController =
              UIHostingController(rootView: HypedListTabView_Previews.previews)
        }
    #endif
}

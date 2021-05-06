//
// Created by Lei Zhao on 5/5/21.
//

import SwiftUI

struct TabBar: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "play.circle.fill")
                    Text("Home")
                }
                .tag(0)
            ContentView()
              .tabItem {
                  Image(systemName: "rectangle.stack.fill")
                  Text("Certificates")
              }
        }
    }
}

class TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }

    #if DEBUG
        @objc class func injected() {
            UIApplication.shared.windows.first?.rootViewController =
              UIHostingController(rootView: TabBar_Previews.previews)
        }
    #endif
}

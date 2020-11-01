//
//  ContentView.swift
//  onBoardScreen
//
//  Created by Lei Zhao on 10/31/20.
//
//

import SwiftUI

struct ContentView: View {

    var subViewControllers = [
        UIHostingController(rootView: SubView(imageString: "爱情")),
        UIHostingController(rootView: SubView(imageString: "科幻")),
        UIHostingController(rootView: SubView(imageString: "喜剧")),
        UIHostingController(rootView: SubView(imageString: "剧情")),
        UIHostingController(rootView: SubView(imageString: "动画")),
        UIHostingController(rootView: SubView(imageString: "恐怖")),
        UIHostingController(rootView: SubView(imageString: "悬疑")),
    ]

    @State(initialValue: 0) var currentPageIndex

    var body: some View {
        VStack {
            ZStack(alignment: .bottomTrailing) {
                PageView(viewControllers: subViewControllers, currentPageIndex: $currentPageIndex)
                  .frame(height: 210)
                PageControl(numOfPages: subViewControllers.count, currentPageIndex: $currentPageIndex)
                  .frame(maxWidth: 100)
                  .padding(.trailing)
            }
            Text("current page: \(currentPageIndex)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

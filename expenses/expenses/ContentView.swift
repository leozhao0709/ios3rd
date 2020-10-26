//
//  ContentView.swift
//  expenses
//
//  Created by Lei Zhao on 10/25/20.
//
//

import SwiftUI

struct ContentView: View {

  private var list = ["xx", "yy", "zz"]
  @State(initialValue: false) private var showSheet;

  var body: some View {
    NavigationView {
      List(list, id: \.self) {
        Text($0)
      }
        .navigationBarTitle("费用支出")
        .navigationBarItems(
          trailing: Button(action: { self.showSheet = true }, label: { Image(systemName: "plus") }))
        .sheet(isPresented: $showSheet, content: {
          AddView(presentMode: $showSheet)
        })
    }
  }
}

class ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }

  #if DEBUG
    @objc class func injected() {
      UIApplication.shared.windows.first?.rootViewController =
        UIHostingController(rootView: ContentView_Previews.previews)
    }
  #endif
}

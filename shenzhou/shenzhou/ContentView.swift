//
//  ContentView.swift
//  shenzhou
//
//  Created by Lei Zhao on 10/26/20.
//
//

import SwiftUI

struct ContentView: View {

  let plans: [Plan] = Bundle.main.decode(path: "./plans.json")

  var body: some View {
    NavigationView {
      List(plans) { plan in
        NavigationLink(destination: PlanView(plan: plan)) {
          Image(plan.imageName)
            .renderingMode(.original)
            .resizable()
            .scaledToFit()
            .frame(width: 44, height: 44)

          VStack(alignment: .leading) {
            Text(plan.name)
            Text(plan.launchDate)
          }
        }
          .buttonStyle(PlainButtonStyle())
      }
        .navigationTitle("神舟任务")
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

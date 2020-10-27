//
//  ContentView.swift
//  tea
//
//  Created by Lei Zhao on 10/26/20.
//
//

import SwiftUI

struct ContentView: View {
  @EnvironmentObject var publishedOrder: PublishedOrder

  var body: some View {
    NavigationView {
      Form {
        Section {
          Stepper(value: self.$publishedOrder.order.num, in: 1...20) {
            Text("奶茶数量(10元/杯): \(publishedOrder.order.num)")
          }
        }

        Section {
          Toggle(isOn: $publishedOrder.specialRequest.animation()) {
            Text("特殊需求")
          }

          if (publishedOrder.specialRequest) {
            Toggle(isOn: $publishedOrder.order.isAddIce) {
              Text("是否加冰")
            }
            Toggle(isOn: $publishedOrder.order.isAddSugar) {
              Text("是否加糖")
            }
          }
        }

        Section {
          NavigationLink(destination: AddAddressView()) { Text("下一步(选择送货地址)") }
        }
      }
        .navigationBarTitle("奶茶订单")
    }
  }
}

class ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
      .environmentObject(PublishedOrder())
  }

  #if DEBUG
    @objc class func injected() {
      UIApplication.shared.windows.first?.rootViewController =
        UIHostingController(rootView: ContentView_Previews.previews)
    }
  #endif
}

//
//  CheckoutView.swift
//  tea
//
//  Created by Lei Zhao on 10/26/20.
//
//

import SwiftUI

struct CheckoutView: View {

  @EnvironmentObject var publishedOrder: PublishedOrder

  var body: some View {
    VStack {
      Text("合计\(10 * publishedOrder.order.num)元")
        .font(.largeTitle)
      Button("下单") {
        print("....\(publishedOrder.order)")
      }
        .padding()
    }
  }
}

class CheckoutView_Previews: PreviewProvider {
  static var previews: some View {
    CheckoutView()
      .environmentObject(PublishedOrder())
  }

  #if DEBUG
    @objc class func injected() {
      UIApplication.shared.windows.first?.rootViewController =
        UIHostingController(rootView: CheckoutView_Previews.previews)
    }
  #endif
}

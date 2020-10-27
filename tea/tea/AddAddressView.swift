//
//  AddAddressView.swift
//  tea
//
//  Created by Lei Zhao on 10/26/20.
//
//

import SwiftUI

struct AddAddressView: View {

  @EnvironmentObject var publishedOrder: PublishedOrder

  var body: some View {
      Form {
        Section {
          TextField("姓名", text: $publishedOrder.order.name)
          TextField("手机", text: $publishedOrder.order.phone)
            .keyboardType(.numberPad)
          TextField("地址", text: $publishedOrder.order.address)
        }

        Section {
          NavigationLink(destination: CheckoutView()) {
            Text("确认订单")
          }
//            .disabled(!self.publishedOrder.hasValidAddress)
        }
      }
        .navigationBarTitle("送达地址", displayMode: .inline)
  }
}

class AddAddressView_Previews: PreviewProvider {
  static var previews: some View {
    AddAddressView()
      .environmentObject(PublishedOrder())
  }

  #if DEBUG
    @objc class func injected() {
      UIApplication.shared.windows.first?.rootViewController =
        UIHostingController(rootView: AddAddressView_Previews.previews)
    }
  #endif
}

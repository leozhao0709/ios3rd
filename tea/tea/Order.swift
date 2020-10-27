//
// Created by Lei Zhao on 10/26/20.
//

import Foundation

struct Order: Codable {
  var num = 1
  var isAddIce = false
  var isAddSugar = false

  var name = ""
  var phone = ""
  var address = ""
}

class PublishedOrder: ObservableObject {

  @Published var order: Order

  @Published var specialRequest = false {
    didSet {
      if !self.specialRequest {
        self.order.isAddIce = false
        self.order.isAddSugar = false
      }
    }
  }

  var hasValidAddress: Bool {
    !self.order.name.isEmpty && !self.order.phone.isEmpty && !self.order.address.isEmpty
  }

  init() {
    self.order = Order()
  }
}
//
// Created by Lei Zhao on 10/25/20.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
  var id = UUID()
  var name: String
  var type: String
  var amount: String
}

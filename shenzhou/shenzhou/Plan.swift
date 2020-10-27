//
// Created by Lei Zhao on 10/26/20.
//

import Foundation

struct Plan: Identifiable, Codable {

  struct Member: Codable {
    let name: String
    let birth: String
  }

  let id: Int
  let name: String
  let launchDate: String
  let member: [Member]?
  let description: String
  let hasBadge: Bool

  var imageName: String {
    self.hasBadge ? "shenzhou\(id)" : "placeholder"
  }
}

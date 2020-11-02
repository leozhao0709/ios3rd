//
// Created by Lei Zhao on 10/31/20.
//

import Foundation

struct Coder: Identifiable, Codable {
    var id = UUID()
    var name: String
    var phone: String
    var isApple: Bool

    init(name: String, phone: String, isApple: Bool) {
        self.name = name
        self.phone = phone
        self.isApple = isApple
    }

    mutating func toggleType() {
        self.isApple.toggle()
    }
}

class Coders: ObservableObject {
    @Published var allCoders: [Coder] = []
}

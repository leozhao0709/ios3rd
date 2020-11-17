//
// Created by Lei Zhao on 11/16/20.
//

import Foundation

struct CustomError: LocalizedError {
    var errorDescription: String? {
        _description
    }
    var failureReason: String? {
        _description
    }

    private var _description: String

    init(_ description: String) {
        self._description = description
    }
}

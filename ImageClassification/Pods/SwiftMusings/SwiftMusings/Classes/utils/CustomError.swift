//
// Created by Lei Zhao on 11/16/20.
//

import Foundation

public struct CustomError: LocalizedError {
    public var errorDescription: String? {
        _description
    }
    public var failureReason: String? {
        _description
    }

    private var _description: String

    init(_ description: String) {
        self._description = description
    }
}

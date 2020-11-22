//
// Created by Lei Zhao on 11/21/20.
//

import Foundation

@propertyWrapper
class Uppercase {

    private(set) var value: String = ""
    
    var wrappedValue: String {
        get { value }
        set {
            value = newValue.uppercased()
        }
    }
}

//
//  File.swift
//  HypedList
//
//  Created by Lei Zhao on 11/20/20.
//

import UIKit
import SwiftUI
import SwiftDate

class HypedEvent: ObservableObject {
    var title: String = ""
    var date: Date = Date()
    var url: String = ""
    var color: Color = .purple
    @Published var image: UIImage?

    func dateAsString() -> String {
        if date.compare(.isThisYear) {
            return date.toFormat("MMM d")
        }
        return date.toFormat("MMM d yyyy")
    }
}

//
// Created by Lei Zhao on 5/5/21.
//

import SwiftUI
import Combine

struct UpdateItem: Identifiable {
    var id = UUID()
    var image: String
    var title: String
    var text: String
    var date: String
}

class UpdateStore: ObservableObject {
    @Published var updateItems = [
        UpdateItem(image: "Card1", title: "SwiftUI Advanced", text: "Take your SwiftUI app to the App Store with advanced techniques like API data, packages and CMS.", date: "JAN 1"),
        UpdateItem(image: "Card2", title: "Webflow", text: "Design and animate a high converting landing page with advanced interactions, payments and CMS", date: "OCT 17"),
        UpdateItem(image: "Card3", title: "ProtoPie", text: "Quickly prototype advanced animations and interactions for mobile and Web.", date: "AUG 27"),
        UpdateItem(image: "Card4", title: "SwiftUI", text: "Learn how to code custom UIs, animations, gestures and components in Xcode 11", date: "JUNE 26"),
        UpdateItem(image: "Card5", title: "Framer Playground", text: "Create powerful animations and interactions with the Framer X code editor", date: "JUN 11")
    ]
}
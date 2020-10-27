//
//  AstronautView.swift
//  shenzhou
//
//  Created by Lei Zhao on 10/26/20.
//
//

import SwiftUI

struct AstronautView: View {

  var astronautName: String

  var astronaut: Astronaut {
    let astronauts: [Astronaut] = Bundle.main.decode(path: "./astronauts.json")
    return astronauts.first {
      $0.name == astronautName
    }!
  }

  var body: some View {
    GeometryReader { proxy in
      ScrollView(.vertical) {
        Image(self.astronaut.name)
          .resizable()
          .scaledToFill()
          .frame(width: proxy.size.width)
        Text(self.astronaut.description)
          .padding()
      }.navigationBarTitle(astronaut.name, displayMode: .inline)
    }
  }
}

class AstronautView_Previews: PreviewProvider {
  static var previews: some View {
    let astronauts: [Astronaut] = Bundle.main.decode(path: "./astronauts.json")
    AstronautView(astronautName: astronauts[0].name)
  }

  #if DEBUG
    @objc class func injected() {
      UIApplication.shared.windows.first?.rootViewController =
        UIHostingController(rootView: AstronautView_Previews.previews)
    }
  #endif
}

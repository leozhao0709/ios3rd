//
//  PlanView.swift
//  shenzhou
//
//  Created by Lei Zhao on 10/26/20.
//
//

import SwiftUI

struct PlanView: View {

  let plan: Plan

  var body: some View {
    GeometryReader { geo in
      ScrollView(.vertical) {
        Image(plan.imageName)
          .resizable()
          .scaledToFit()
          .frame(width: geo.size.width * 0.7)
          .padding(.top)
        Text(plan.description)
          .padding()

        if let members = plan.member {
          List(members, id: \.name) { member in
            NavigationLink(destination: AstronautView(astronautName: member.name)) {
              Image(member.name)
                .resizable()
                .scaledToFill()
                .frame(width: 83, height: 60)
                .clipShape(Capsule())

              VStack(alignment: .leading) {
                Text(member.name)
                  .font(.headline)
                Text(member.birth)
                  .font(.subheadline)
                  .foregroundColor(.secondary)
              }
            }
          }.scaledToFit()
        }
      }
        .navigationBarTitle(plan.name, displayMode: .inline)
    }
  }
}

class PlanView_Previews: PreviewProvider {
  static let plans: [Plan] = Bundle.main.decode(path: "./plans.json")
  static var previews: some View {
    PlanView(plan: plans[6])
  }

  #if DEBUG
    @objc class func injected() {
      UIApplication.shared.windows.first?.rootViewController =
        UIHostingController(rootView: PlanView_Previews.previews)
    }
  #endif
}

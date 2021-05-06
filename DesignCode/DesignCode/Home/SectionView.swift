//
//  SectionView.swift
//  DesignCode
//
//  Created by Lei Zhao on 5/4/21.
//
//

import SwiftUI

struct SectionView: View {

    var section: Section

    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                HStack(alignment: .top) {
                    Text(section.title)
                      .font(.system(size: 24, weight: .bold))
                      .frame(width: 160, alignment: .leading)
                      .foregroundColor(.white)
                    Image(section.logo)
                }
                Text(section.text.uppercased())
            }

            section.image
              .resizable()
              .aspectRatio(contentMode: .fit)
        }
          .padding(.top, 20)
          .frame(width: 275, height: 275)
          .background(section.color)
          .cornerRadius(30)
          .shadow(color: section.color.opacity(0.3), radius: 20, x: 0, y: 20)
    }
}

class SectionView_Previews: PreviewProvider {
    static var previews: some View {
        SectionView(section: Section(title: "Prototype designs in SwiftUI", text: "18 sections", logo: "Logo1", image: Image("Card1"), color: Color("card1")))
    }

    #if DEBUG
        @objc class func injected() {
            UIApplication.shared.windows.first?.rootViewController =
              UIHostingController(rootView: SectionView_Previews.previews)
        }
    #endif
}

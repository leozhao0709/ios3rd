//
// Created by Lei Zhao on 5/6/21.
//

import SwiftUI

struct RingView: View {

    var color1 = Color(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1))
    var color2 = Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1))
    var width: CGFloat = 44
    var height: CGFloat = 44
    var percent: CGFloat = 44

    var body: some View {
        let multiplier = width / 44
        let progress = percent / 100

        ZStack {
            Circle()
              .stroke(Color.black.opacity(0.1), style: StrokeStyle(lineWidth: 5 * multiplier))
              .frame(width: width, height: height)

            Circle()
              .trim(from: 0, to: progress)
              .stroke(
                LinearGradient(gradient: Gradient(colors: [color1, color2]), startPoint: .topTrailing, endPoint: .bottomLeading),
                style: StrokeStyle(
                  lineWidth: 5 * multiplier,
                  lineCap: .round,
                  lineJoin: .round,
                  miterLimit: .infinity,
                  dash: [20, 0], // [dash, gap]
                  dashPhase: 0
                )
              )
              .frame(width: width, height: height)
              .shadow(color: color2.opacity(0.1), radius: 3, x: 0, y: 3)
              .rotationEffect(.degrees(-90))

            Text("\(Int(percent))%")
              .font(.system(size: 14 * multiplier))
              .fontWeight(.bold)
        }
    }
}

class RingView_Previews: PreviewProvider {
    static var previews: some View {
        RingView()
    }

    #if DEBUG
        @objc class func injected() {
            UIApplication.shared.windows.first?.rootViewController =
              UIHostingController(rootView: RingView_Previews.previews)
        }
    #endif
}

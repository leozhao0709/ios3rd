//
//  ContentView.swift
//  basicGesture2
//
//  Created by Lei Zhao on 11/2/20.
//
//

import SwiftUI

struct ContentView: View {

    @State private var scaledAmount: CGFloat = 1
    @State private var rotateDeg: Angle = .zero

    @State private var offset: CGSize = .zero

    var body: some View {
        let dragGesture = DragGesture()
          .onChanged { value in
              self.offset = value.translation
          }
          .onEnded { v in
              self.offset = .zero
              self.scaledAmount = 1
          }

        let longGesture = LongPressGesture()
            .onEnded { v in self.scaledAmount = 1.5 }

        VStack(spacing: 50) {
            Circle()
                .fill(Color.green)
                .frame(width: 60, height: 60)
                .scaleEffect(scaledAmount)
                .offset(offset)
                .animation(.easeInOut)
                .gesture(longGesture.sequenced(before: dragGesture))

            TextWithBackground("disable gesture")
                .onTapGesture { print("....tap") }
                .allowsHitTesting(false)

            TextWithBackground("pinch(捏合手势)")
              .scaleEffect(scaledAmount)
              .animation(.easeInOut)
              .gesture(
                MagnificationGesture()
                  .onChanged { value in
                      self.scaledAmount = value
                      print("pinch onChanged \(value)")
                  }
                  .onEnded { value in
                      self.scaledAmount = 1
                      print("pinch onEnded \(value)")
                  }
              )

            TextWithBackground("rotate")
              .rotationEffect(rotateDeg)
              .animation(.easeInOut)
              .gesture(
                RotationGesture()
                  .onChanged { value in
                      self.rotateDeg = value
                      print("...rotation onChanged \(value)")
                  }
                  .onEnded { value in
                      self.rotateDeg = .zero
                      print("...rotation onEnded \(value)")
                  }

              )
        }

        VStack {
            TextWithBackground("parent tap only")
              .onTapGesture {
                  print("child tap")
              }
        }
          .highPriorityGesture(TapGesture()
            .onEnded {
                print("parent tap only")
            }
          )

        VStack {
            TextWithBackground("parent tap simultaneous")
              .onTapGesture {
                  print("child tap")
              }
        }
          .simultaneousGesture(
            TapGesture()
              .onEnded {
                  print("parent tap simultaneous")
              }
          )
    }
}

class ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }

    #if DEBUG
        @objc class func injected() {
            UIApplication.shared.windows.first?.rootViewController =
              UIHostingController(rootView: ContentView_Previews.previews)
        }
    #endif
}

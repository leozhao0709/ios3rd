//
//  ContentView.swift
//  weatherApp
//
//  Created by Lei Zhao on 11/6/20.
//

import SwiftUI

struct ContentView: View {

    @ObservedObject var locationManager = LocationManager.sharedInstance()

    var body: some View {
        NavigationView {
            GeometryReader { proxy in
                ZStack {
                    Image("background")
                      .resizable()
                      .frame(width: proxy.size.width, height: proxy.size.height)
                      .scaledToFit()

                    VStack {
                        Text("\(locationManager.lastLocation?.coordinate.latitude ?? 0)")
                        Text("\(locationManager.lastLocation?.coordinate.longitude ?? 0)")
                        HStack {
                            Spacer()
                            VStack(alignment: .trailing) {
                                NavigationLink(destination: Text("123")) {
                                    Image("switch")
                                }
                                    .padding(.trailing, 20)

                                Text("4°")
                                  .foregroundColor(.white)
                                  .font(.system(size: 100))
                                  .padding(.trailing, 40)
                            }
                        }.offset(y: -50)

                        Image("sunny")
                          .resizable()
                          .frame(width: 180, height: 180)

                        HStack {
                            Text("New York")
                              .foregroundColor(.white)
                              .font(.system(size: 50))
                              .offset(x: 10)
                            Spacer()
                        }.offset(y: 100)
                    }
                }
            }
              .edgesIgnoringSafeArea(.all)
        }
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

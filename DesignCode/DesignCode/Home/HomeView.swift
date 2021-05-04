//
//  HomeView.swift
//  DesignCode
//
//  Created by Lei Zhao on 5/3/21.
//
//

import SwiftUI

struct HomeView: View {

    @State var showProfile = false

    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
              .ignoresSafeArea()
            VStack {
                HStack {
                    Text("Watching")
                      .font(.system(size: 28, weight: .bold))
                    Spacer()
                    Button(action: { showProfile.toggle() }, label: {
                        Image("Avatar")
                          .resizable()
                          .frame(width: 36, height: 36)
                          .clipShape(Circle())
                    })
                }
                  .padding(.horizontal)
                  .padding(.top, 30)

                Spacer()
            }
              .padding(.top, 44)
              .background(Color.white)
              .cornerRadius(30)
              .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
              .rotation3DEffect(.degrees(showProfile ? -10 : 0), axis: (x: 1, y: 0, z: 0))
              .scaleEffect(showProfile ? 0.9 : 1)
              .animation(.spring(response: 0.5, dampingFraction: 0.6))
              .ignoresSafeArea()


            MenuView()
              .offset(y: showProfile ? 0 : 600)
              .animation(.spring(response: 0.5, dampingFraction: 0.6))
        }
    }
}

class HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }

    #if DEBUG
        @objc class func injected() {
            UIApplication.shared.windows.first?.rootViewController =
              UIHostingController(rootView: HomeView_Previews.previews)
        }
    #endif
}

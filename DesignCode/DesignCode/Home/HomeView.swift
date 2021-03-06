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
    @State(initialValue: CGSize.zero) var viewState
    @State var showUpdate = false
    let sectionData = [
        Section(title: "Prototype designs in SwiftUI", text: "18 sections", logo: "Logo1", image: Image("Card1"), color: Color("card1")),
        Section(title: "Build a SwiftUi app", text: "20 sections", logo: "Logo2", image: Image("Card2"), color: Color("card2")),
        Section(title: "SwiftUI Advanced", text: "20 sections", logo: "Logo3", image: Image("Card3"), color: Color("card3"))
    ]

    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
              .ignoresSafeArea()
            home()
              .padding(.top, 44)
              .background(Color.white)
              .cornerRadius(30)
              .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
              .offset(y: showProfile ? -450 : 0)
              .rotation3DEffect(.degrees(showProfile ? Double((viewState.height / 10) - 10) : 0), axis: (x: 1, y: 0, z: 0))
              .scaleEffect(showProfile ? 0.9 : 1)
              .animation(.spring(response: 0.5, dampingFraction: 0.6))
              .ignoresSafeArea()

            MenuView()
              .background(Color.black.opacity(0.001))
              .offset(y: showProfile ? 0 : UIScreen.main.bounds.height)
              .offset(y: viewState.height)
              .animation(.spring(response: 0.5, dampingFraction: 0.6))
              .onTapGesture {
                  showProfile.toggle()
              }
              .gesture(
                DragGesture()
                  .onChanged { value in
                      viewState = value.translation
                  }
                  .onEnded { (v: DragGesture.Value) in
                      if viewState.height > 50 {
                          showProfile = false
                      }
                      viewState = .zero
                  }
              )
        }
    }

    private func home() -> some View {
        VStack {
            HStack {
                Text("Watching")
                  .font(.system(size: 28, weight: .bold))
                Spacer()

                AvatarView(showProfile: $showProfile)

                Button(action: { showUpdate.toggle() }) {
                    Image(systemName: "bell")
                      .renderingMode(.original)
                      .font(.system(size: 16, weight: .medium))
                      .frame(width: 36, height: 36)
                      .background(Color.white)
                      .cornerRadius(18)
                      .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 10)
                      .shadow(color: .black.opacity(0.1), radius: 1, x: 0, y: 1)
                }
                  .sheet(isPresented: $showUpdate) {
                      UpdateView()
                  }
            }
              .padding(.horizontal)
              .padding(.leading, 14)
              .padding(.top, 30)

            HStack {
                RingView(color1:  Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)), color2: Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)), percent: 68)
                VStack(alignment: .leading, spacing: 4) {
                    Text("6 minutes left")
                        .font(.subheadline)
                        .fontWeight(.bold)
                    Text("Watched 10 mins today")
                        .font(.caption)
                }
            }
                .padding(8)
                .background(Color.white)
                .cornerRadius(20)
                .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
                .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(sectionData) { item in
                        SectionView(section: item)
                    }
                }
                  .padding(30)
            }

            Spacer()
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

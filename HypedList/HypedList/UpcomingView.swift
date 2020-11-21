//
//  UpcomingView.swift
//  HypedList
//
//  Created by Lei Zhao on 11/20/20.
//

import SwiftUI

struct UpcomingView: View {

    @State var showCreateView = false
    var hypedEvents: [HypedEvent] = []

    var body: some View {
        NavigationView {
            VStack {
                if hypedEvents.count == 0 {
                    Text("""
                         Nothing to look forward to 😢
                         Create an event or check out the Discover tab!
                         """
                    ).multilineTextAlignment(.center)
                } else {

                }
            }
              .navigationTitle("Upcoming")
              .navigationBarItems(
                trailing: Button(action: {
                    self.showCreateView.toggle()
                }, label: {
                    Image(systemName: "calendar.badge.plus")
                      .foregroundColor(.blue)
                })
                  .sheet(isPresented: $showCreateView, content: {
                      CreateHypedEventView()
                  })
              )
        }
    }
}

class UpcomingView_Previews: PreviewProvider {
    static var previews: some View {
        UpcomingView()
    }

    #if DEBUG
        @objc class func injected() {
            UIApplication.shared.windows.first?.rootViewController =
              UIHostingController(rootView: UpcomingView_Previews.previews)
        }
    #endif
}

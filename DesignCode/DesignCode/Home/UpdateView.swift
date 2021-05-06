//
// Created by Lei Zhao on 5/5/21.
//

import SwiftUI

struct UpdateView: View {

    @ObservedObject var store = UpdateStore()

    var body: some View {
        NavigationView {
            List(store.updateItems) { (item: UpdateItem) in
                NavigationLink(destination: Text(item.text)) {
                    HStack {
                        Image(item.image)
                          .resizable()
                          .aspectRatio(contentMode: .fit)
                          .frame(width: 80, height: 80)
                            .background(Color.black)
                          .cornerRadius(20)
                        VStack(alignment: .leading, spacing: 8) {
                            Text(item.title)
                              .font(.system(size: 20))
                              .font(.title)

                            Text(item.text)
                                .font(.system(.subheadline))
                                .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))

                            Text(item.date)
                                .font(.caption)
                        }
                    }
                }
            }
              .navigationBarTitle("Updates")
        }
    }
}

class UpdateView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateView()
    }

    #if DEBUG
        @objc class func injected() {
            UIApplication.shared.windows.first?.rootViewController =
              UIHostingController(rootView: UpdateView_Previews.previews)
        }
    #endif
}

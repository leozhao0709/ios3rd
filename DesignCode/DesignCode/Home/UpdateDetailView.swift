//
// Created by Lei Zhao on 5/5/21.
//

import SwiftUI

struct UpdateDetailView: View {
    var updateItem: UpdateItem

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Image(updateItem.image)
                  .resizable()
                  .aspectRatio(contentMode: .fit)
                  .frame(maxWidth: .infinity)
                Text(updateItem.text)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
              .padding(.horizontal, 20)
              .navigationBarTitle(updateItem.title)
        }
    }
}

class UpdateDetailView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateDetailView(updateItem: updateData[0])
    }

    #if DEBUG
        @objc class func injected() {
            UIApplication.shared.windows.first?.rootViewController =
              UIHostingController(rootView: UpdateDetailView_Previews.previews)
        }
    #endif
}

//
// Created by Lei Zhao on 5/5/21.
//

import SwiftUI

struct UpdateView: View {

    @ObservedObject var store = UpdateStore()

    var body: some View {
        NavigationView {
            List {
                ForEach(store.updateItems) { (item: UpdateItem) in
                    NavigationLink(destination: UpdateDetailView(updateItem: item)) {
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
                                  .lineLimit(2)
                                  .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))

                                Text(item.date)
                                  .font(.caption)
                            }
                        }
                    }
                }
                  .onDelete { (v: IndexSet) in
                      store.updateItems.remove(atOffsets: v)
                  }
                  .onMove { set, i in
                      store.updateItems.move(fromOffsets: set, toOffset: i)
                  }
            }
              .navigationBarTitle("Updates")
              .navigationBarItems(leading: Button(action: { addUpdateItem() }) {
                  Image(systemName: "plus")
              }, trailing: EditButton())
        }
    }

    func addUpdateItem() {
        store.updateItems.append(UpdateItem(image: "Card1", title: "New Item", text: "text", date: "Jan 1"))
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

//
// Created by Lei Zhao on 10/25/20.
//

import SwiftUI

struct AddView: View {

  private let types = ["生活用品", "数码家电", "服饰", "ios学习"]
  @State(initialValue: "") private var name
  @State(initialValue: 0) private var type
  @State(initialValue: "") private var amount

//  @Environment(\.presentationMode) var presentMode
  @Binding var presentMode: Bool

  var body: some View {
    NavigationView {
      Form {
        TextField("支出名", text: $name)
        Picker("种类", selection: $type) {
          ForEach(types.indices) {
            Text(types[$0])
          }
        }
        TextField("花费", text: $amount)
          .keyboardType(.numberPad)
      }
        .navigationBarTitle("添加支出")
        .navigationBarItems(trailing: Button(action: {
//          presentMode.wrappedValue.dismiss()
          presentMode = false
        }, label: { Text("保存") }))
    }
  }
}

class AddView_Previews: PreviewProvider {
  @State static var presentMode = true
  static var previews: some View {
    AddView(presentMode: $presentMode)
  }


  #if DEBUG
    @objc class func injected() {
      UIApplication.shared.windows.first?.rootViewController =
        UIHostingController(rootView: AddView_Previews.previews)
    }
  #endif
}

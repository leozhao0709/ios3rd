//
//  ContentView.swift
//  landmark
//
//  Created by Lei Zhao on 10/22/20.
//
//

import SwiftUI

struct ContentView: View {

  @State private var name = ""
  @State private var phone = ""
  @State private var address = ""
  @State private var tabIndex = 0
  @State private var showAlert = false

  let tags = ["家", "学校", "公司"]

  var confirmMsg: String {
    """
    收货人是：\(name)
    手机是：\(phone)
    地址是：\(address)
    标签是：\(tags[tabIndex])
    """
  }

  var body: some View {
    NavigationView {
      Form {
        Section {
          HStack {
            Text("收货人")
            TextField("请填写收货人名字", text: $name)
          }
          HStack {
            Text("手机")
            TextField("请填写收货人手机", text: $phone)
              .keyboardType(.numberPad)
          }
          HStack {
            Text("详细地址")
            TextField("请填写收货人地址", text: $address)
          }
        }


        Section(header: Text("标签")) {
          Picker("xx", selection: $tabIndex) {
            ForEach(0..<tags.count) {
              Text(self.tags[$0])
            }
          }
            .pickerStyle(SegmentedPickerStyle())
        }

        Section {
          HStack {
            Spacer()
            Button("填好了") {
              self.showAlert = true
            }
              .disabled(name.isEmpty || phone.isEmpty || address.isEmpty)
            Spacer()
          }
        }
      }
        .navigationBarTitle("确认收货地址")
        .alert(isPresented: $showAlert) {
          Alert(
            title: Text("确认地址"),
            message: Text(confirmMsg),
            dismissButton: .default(Text("确认了")))
        }
    }

  }
}

class ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }

  #if DEBUG
  @objc class func injected(A a: Int) {
    UIApplication.shared.windows.first?.rootViewController =
      UIHostingController(rootView: ContentView_Previews.previews)
  }
  #endif
}

//
//  CoderView.swift
//  contact
//
//  Created by Lei Zhao on 10/31/20.
//
//

import SwiftUI

enum CoderType {
    case all, apple, android
}

struct CoderView: View {

    @EnvironmentObject var coders: Coders

    let coderType: CoderType

    var persons: [Coder] {
        switch coderType {
        case .all:
            return coders.allCoders
        case .apple:
            return coders.allCoders.filter {
                $0.isApple
            }
        case .android:
            return coders.allCoders.filter {
                !$0.isApple
            }
        }
    }

    var title: String {
        switch coderType {
        case .all:
            return "所有开发者"
        case .apple:
            return "苹果开发者"
        case .android:
            return "安卓开发者"
        }
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(persons) { person in
                    VStack {
                        Text(person.name)
                          .font(.headline)
                        Text(person.phone)
                          .foregroundColor(.secondary)
                    }
                      .contextMenu {
                          Button(person.isApple ? "添加到安卓用户" : "添加到苹果用户") {
                              let coderIndex = coders.allCoders.firstIndex {
                                  $0.id == person.id
                              }
                              if let index = coderIndex {
                                  coders.allCoders[index].toggleType()
                              }
                          }
                      }
                }
            }
              .navigationBarTitle(title)
              .navigationBarItems(trailing: Button("扫一扫") {
                  let coder = Coder(name: "test", phone: "123456", isApple: true)
                  coders.allCoders.append(coder)
              })
        }
    }
}

class CoderView_Previews: PreviewProvider {
    static var previews: some View {
        CoderView(coderType: .all)
    }

    #if DEBUG
        @objc class func injected() {
            UIApplication.shared.windows.first?.rootViewController =
              UIHostingController(rootView: ContentView_Previews.previews)
        }
    #endif
}

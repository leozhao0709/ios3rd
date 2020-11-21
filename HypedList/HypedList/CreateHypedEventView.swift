//
//  CreateHypedEventView.swift
//  HypedList
//
//  Created by Lei Zhao on 11/20/20.
//

import SwiftUI
import SwiftMusings

struct CreateHypedEventView: View {
    @ObservedObject var hypedEvent: HypedEvent = HypedEvent()
    @State var showTime = false
    @State var showImagePicker = false

    var body: some View {
        Form {
            Section {
                FormLabelView(title: "Title", imageName: "keyboard", iconColor: .green)
                TextField("Family Vacation", text: $hypedEvent.title)
                  .autocapitalization(.words)
            }

            Section {
                FormLabelView(title: "Date", imageName: "calendar")
                DatePicker("Date", selection: $hypedEvent.date, displayedComponents: showTime ? [.date, .hourAndMinute] : .date)
                  .datePickerStyle(GraphicalDatePickerStyle())
                Toggle(isOn: $showTime, label: {
                    FormLabelView(title: "Time", imageName: "clock.fill")
                })
            }

            Section {
                HStack {
                    FormLabelView(title: "Image", imageName: "camera", iconColor: .purple)
                    Spacer()
                    Button(hypedEvent.image == nil ? "Pick Image" : "Remove Image") {
                        if hypedEvent.image == nil {
                            self.showImagePicker.toggle()
                        } else {
                            hypedEvent.image = nil
                        }
                    }
                      .buttonStyle(BorderlessButtonStyle())
                      .foregroundColor(hypedEvent.image == nil ? .blue : .red)
                      .sheet(isPresented: $showImagePicker, content: {
                          ImagePickerView(onPickImage: { (uiImage) in
                              hypedEvent.image = uiImage
                              self.showImagePicker.toggle()
                          }, onPickVideo: nil, onCancelPick: {
                              self.showImagePicker.toggle()
                          }, onError: nil)
                      })
                }

                if let uiImage = hypedEvent.image {
                    Button(action: {
                        self.showImagePicker.toggle()
                    }) {
                        Image(uiImage: uiImage)
                          .resizable()
                          .scaledToFit()
                    }
                }
            }

            Section {
                ColorPicker(selection: $hypedEvent.color, label: {
                    FormLabelView(title: "Color", imageName: "eyedropper", iconColor: .yellow)
                })
            }

            Section {
                FormLabelView(title: "URL", imageName: "link", iconColor: .orange)
                TextField("nintendo.com", text: $hypedEvent.url)
            }
        }
    }
}

class CreateHypedEventView_Previews: PreviewProvider {
    static var previews: some View {
        CreateHypedEventView()
    }

    #if DEBUG
        @objc class func injected() {
            UIApplication.shared.windows.first?.rootViewController =
              UIHostingController(rootView: CreateHypedEventView_Previews.previews)
        }
    #endif
}

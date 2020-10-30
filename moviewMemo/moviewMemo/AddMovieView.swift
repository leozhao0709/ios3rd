//
//  AddMovieView.swift
//  movieMemo
//
//  Created by Lei Zhao on 10/27/20.
//
//

import SwiftUI

struct AddMovieView: View {
    @Environment(\.managedObjectContext) private var viewContext

    let types = ["科幻", "恐怖", "喜剧", "动画", "剧情", "爱情", "悬疑"]
    @State(initialValue: "") private var name
    @State(initialValue: 2) private var typeIndex
    @State(initialValue: "") private var review
    @State(initialValue: 0) private var rating
    @Binding var showSheet: Bool

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("电影名", text: $name)
                    Picker("类型", selection: $typeIndex) {
                        ForEach(types.indices) {
                            Text(self.types[$0])
                        }
                    }
                }
                Section(header: Text("点评")) {
                    RatingView(rating: $rating)
                    TextEditor(text: $review)
                }
                Section {
                    Button("提交") {
                        let movie = Movie(context: viewContext)
                        movie.name = name
                        movie.type = types[typeIndex]
                        movie.rating = Int16(rating)
                        movie.review = review

                        try? viewContext.save()
                        self.showSheet = false
                    }
                }
            }
                .navigationBarTitle("添加电影")
        }
    }
}

class AddMovieView_Previews: PreviewProvider {
    static var previews: some View {
        AddMovieView(showSheet: .constant(false))
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }

    #if DEBUG
        @objc class func injected() {
            UIApplication.shared.windows.first?.rootViewController =
                UIHostingController(rootView: AddMovieView_Previews.previews)
        }
    #endif
}

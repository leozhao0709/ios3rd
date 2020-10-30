//
//  MovieDetailView.swift
//  moviewMemo
//
//  Created by Lei Zhao on 10/29/20.
//
//

import SwiftUI
import CoreData

struct MovieDetailView: View {
    let movie: Movie
    @Environment(\.presentationMode) private var presentationMode
    @Environment(\.managedObjectContext) private var viewContext

    @State(initialValue: false) private var showAlert

    var body: some View {
        GeometryReader { proxy in
            VStack {
                ZStack(alignment: .bottomTrailing) {
                    Image(movie.type ?? "剧情")
                      .frame(width: proxy.size.width)
                    Text(movie.type ?? "剧情")
                      .font(.caption)
                      .fontWeight(.bold)
                      .padding(8)
                      .foregroundColor(.white)
                      .background(Color.black.opacity(0.75))
                      .clipShape(Capsule())
                      .offset(x: -5, y: -5)

                }
                Text(movie.review ?? "no review")
                  .padding()
                RatingView(rating: .constant(Int(movie.rating)))
                  .font(.largeTitle)
            }
              .navigationBarTitle(Text(movie.name ?? "无名电影"), displayMode: .inline)
              .navigationBarItems(trailing: Button(action: { self.showAlert.toggle() }) {
                  Image(systemName: "trash")
              })

        }
          .alert(isPresented: $showAlert) {
              Alert(
                title: Text("删除电影"),
                message: Text("确认删除?"),
                primaryButton: .destructive(Text("删除")) {
                    viewContext.delete(movie)
                    try? viewContext.save()
                    presentationMode.wrappedValue.dismiss()
                }, secondaryButton: .cancel(Text("取消")))
          }
    }
}

class MovieDetailView_Previews: PreviewProvider {
    static let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    static var previews: some View {
        let movie = Movie(context: context)
        movie.id = UUID()
        movie.name = "唐人街探案3"
        movie.type = "喜剧"
        movie.rating = 4
        movie.review = "非常搞笑的电影"

        return MovieDetailView(movie: movie)
    }

    #if DEBUG
        @objc class func injected() {
            UIApplication.shared.windows.first?.rootViewController =
              UIHostingController(rootView: MovieDetailView_Previews.previews)
        }
    #endif
}

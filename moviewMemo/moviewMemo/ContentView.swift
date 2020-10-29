//
//  ContentView.swift
//  moviewMemo
//
//  Created by Lei Zhao on 10/27/20.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Movie.rating, ascending: false)],
        animation: .default)
    private var movies: FetchedResults<Movie>

    @State(initialValue: false) private var showSheet

    var body: some View {
        NavigationView {
            List {
                ForEach(movies) { movie in
                    NavigationLink(destination: MovieDetailView()) {
                        HStack {
                            Text(self.getEmoji(num: movie.rating))
                                .font(.largeTitle)
                            VStack(alignment: .leading) {
                                Text(movie.name ?? "123")
                                    .font(.headline)
                                Text(movie.type ?? "喜剧")
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
            }
                .navigationBarTitle("看过的电影")
                .navigationBarItems(leading: EditButton(), trailing: Button(action: {
                    showSheet.toggle()
                }) {
                    Image(systemName: "plus")
                })
        }
            .sheet(isPresented: $showSheet) {
                AddMovieView(showSheet: $showSheet)
            }
    }
}

extension ContentView {
    private func getEmoji(num: Int16) -> String {
        switch num {
        case 1:
            return "1️⃣"
        case 2:
            return "2️⃣"
        case 3:
            return "3️⃣"
        case 4:
            return "4️⃣"
        case 5:
            return "5️⃣"
        default:
          return "0️⃣"
        }
    }
}

class ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }

    #if DEBUG
        @objc class func injected() {
            UIApplication.shared.windows.first?.rootViewController =
                UIHostingController(rootView: ContentView_Previews.previews)
        }
    #endif
}

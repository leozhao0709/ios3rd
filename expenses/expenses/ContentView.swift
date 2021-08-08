//
//  ContentView.swift
//  expenses
//
//  Created by Lei Zhao on 10/25/20.
//
//

import SwiftUI

struct ContentView: View {

  @State(initialValue: false) private var showSheet;
  @EnvironmentObject var expense: Expense

  var body: some View {
    NavigationView {
      List {
        ForEach(expense.expenses) { expense in
          HStack {
            VStack(alignment: .leading) {
              Text(expense.name).font(.headline)
              Text(expense.type)
            }
            Spacer()
            Text(expense.amount)
          }
        }
          .onDelete { indexSet in
            expense.expenses.remove(atOffsets: indexSet)
          }
      }
        .navigationBarTitle("费用支出123")
        .navigationBarItems(
          trailing: Button(action: { self.showSheet = true }, label: { Image(systemName: "plus") }))
        .sheet(isPresented: $showSheet, content: {
          AddView(presentMode: $showSheet)
        })
    }
  }
}

class ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
      .environmentObject(Expense())
  }

  #if DEBUG
    @objc class func injected() {
      UIApplication.shared.windows.first?.rootViewController =
        UIHostingController(rootView: ContentView_Previews.previews)
    }
  #endif
}

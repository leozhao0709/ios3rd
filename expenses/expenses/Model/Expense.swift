//
// Created by Lei Zhao on 10/25/20.
//

import Foundation

class Expense: ObservableObject {
  @Published var expenses : [ExpenseItem] {
    didSet {
      guard let data = try? JSONEncoder().encode(self.expenses) else {
        print("encode fail")
        return
      }
      UserDefaults.standard.set(data, forKey: "expenses")
    }
  }

  init() {
    guard let data = UserDefaults.standard.data(forKey: "expenses"),
          let expenses = try? JSONDecoder().decode([ExpenseItem].self, from: data) else {
      self.expenses = [
        ExpenseItem(name: "Macbook pro", type: "数码家电", amount: "1600"),
        ExpenseItem(name: "iOS 教程", type: "ios学习", amount: "30"),
      ]
      return
    }

    self.expenses = expenses
  }
}

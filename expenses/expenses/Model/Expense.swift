//
// Created by Lei Zhao on 10/25/20.
//

import Foundation

class Expense: ObservableObject {
  @Published var expenses: [ExpenseItem] {
    didSet {
      UserDefaults.standard.set(self.expenses, forKey: "expenses")
    }
  }

  init() {
    guard let data: [ExpenseItem] = UserDefaults.standard.array(forKey: "expenses") as? [ExpenseItem] else {
      self.expenses = [
        ExpenseItem(name: "Macbook pro", type: "数码家电", amount: "1600"),
        ExpenseItem(name: "iOS 教程", type: "ios学习", amount: "30"),
      ]
      return
    }

    self.expenses = data
  }
}

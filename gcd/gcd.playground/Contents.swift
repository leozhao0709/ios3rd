import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

print("start")
    print(Thread.current)
    let searialQueue = DispatchQueue(label: "queuename")
    searialQueue.sync {
        print("Download1.....\(Thread.current)")
    }
    searialQueue.sync {
        print("Download2.....\(Thread.current)")
    }
    searialQueue.sync {
        print("Download3.....\(Thread.current)")
    }
    print("end-----")
DispatchQueue.main.asyncAfter(deadline: .now()+1) {
        print("1s late to run")
    }

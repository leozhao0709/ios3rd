//
// Created by Lei Zhao on 10/31/20.
//

import SwiftUI

struct PageView: UIViewControllerRepresentable {

    var viewControllers: [UIViewController]
    @Binding var currentPageIndex: Int

    func makeUIViewController(context: Context) -> UIPageViewController {
        let pageViewController = UIPageViewController(transitionStyle:
        .scroll, navigationOrientation: .horizontal)
        pageViewController.dataSource = context.coordinator
        pageViewController.delegate = context.coordinator
        return pageViewController
    }

    func updateUIViewController(_ uiViewController: UIPageViewController, context: Context) {
        // first render
        uiViewController.setViewControllers([viewControllers[currentPageIndex]], direction: .forward, animated: true)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    class Coordinator: NSObject, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

        var parent: PageView

        init(parent: PageView) {
            self.parent = parent
        }

        func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
            guard let index = parent.viewControllers.firstIndex(of: viewController) else {
                return nil
            }

            if index == 0 {
                return parent.viewControllers.last
            }

            return parent.viewControllers[index - 1]
        }


        func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
            guard let index = parent.viewControllers.firstIndex(of: viewController) else {
                return nil
            }

            if index == parent.viewControllers.count - 1 {
                return parent.viewControllers.first
            }

            return parent.viewControllers[index + 1]
        }

        func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
            if completed,
               let visibleViewController = pageViewController.viewControllers?.first,
               let index = parent.viewControllers.firstIndex(of: visibleViewController) {
                parent.currentPageIndex = index
            }
        }
    }
}

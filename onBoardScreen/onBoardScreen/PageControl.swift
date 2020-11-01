//
// Created by Lei Zhao on 10/31/20.
//

import SwiftUI

struct PageControl: UIViewRepresentable {
    var numOfPages: Int
    @Binding var currentPageIndex: Int

    func makeUIView(context: Context) -> UIPageControl {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = numOfPages
        pageControl.currentPageIndicatorTintColor = .orange
        pageControl.pageIndicatorTintColor = .white
        return pageControl
    }

    func updateUIView(_ uiView: UIPageControl, context: Context) {
        uiView.currentPage = currentPageIndex
    }
}

//  CarouselPageViewController.swift
//  CarouselSample
//
//  Created by macmini41 on 17/10/22.
//  Copyright © 2022 MB. All rights reserved.
//
import Foundation
import UIKit

protocol CarouselPageViewControllerDelegate {
    func setCollectionPageIndex(index: Int)
}

class CarouselPageViewController: UIPageViewController, UIPageViewControllerDelegate {
    fileprivate var items: [UIViewController] = []
    var numberOfPages: Int = 5
    var currentPageIndex: Int?
    private var pendingIndex: Int?
    var carouselDelegate: CarouselPageViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        populateItems()
        if let firstViewController = items.first {
            self.dataSource = self
            self.delegate = self
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    }

    fileprivate func populateItems() {
        currentPageIndex = 0
        let text = ["One", "Two", "Three", "Four", "Five"]
        let backgroundColor: [UIColor] = [.blue, .red, .green, .black, .yellow]
        for (index, symbolTxt) in text.enumerated() {
            let view = createCarouselItemControler(with: symbolTxt, with: backgroundColor[index])
            items.append(view)
        }
    }

    fileprivate func createCarouselItemControler(with titleText: String?, with color: UIColor?) -> UIViewController {
        let viewC = UIViewController()
        viewC.title = titleText
        viewC.view.backgroundColor = color
        return viewC
    }
}

// MARK: - DataSource

extension CarouselPageViewController {
    // MARK: - Custom Methods
    func setCurrentIndex(index: Int) {
        if index < self.items.count {
            if index < self.currentPageIndex ?? 0 {
                self.setViewControllers([self.items[index]], direction: .reverse, animated: true, completion: nil)
            } else {
                self.setViewControllers([self.items[index]], direction: .forward, animated: true, completion: nil)
            }
            self.currentPageIndex = index
        }
    }
}
extension CarouselPageViewController: UIPageViewControllerDataSource {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let currentIndex = self.items.firstIndex(of: viewController)!

        let previousIndex = currentIndex - 1

        guard previousIndex >= 0 else {
            return nil
        }

        guard items.count > previousIndex else {
            return nil
        }

        return items[previousIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let currentIndex = self.items.firstIndex(of: viewController)!
        let nextIndex = currentIndex + 1

        guard items.count != nextIndex else {
            return nil
        }

        guard items.count > nextIndex else {
            return nil
        }

        return items[nextIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        self.pendingIndex = self.items.firstIndex(of: pendingViewControllers.first!)
    }

    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            self.currentPageIndex = self.pendingIndex
            carouselDelegate?.setCollectionPageIndex(index: self.pendingIndex ?? 0)
        }
    }

}

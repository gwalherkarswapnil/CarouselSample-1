//
//  CarouselViewController.swift
//  CarouselSample
//
//  Created by macmini41 on 17/10/22.
//  Copyright © 2022 MB. All rights reserved.
//
import UIKit

class CarouselViewController: UIViewController, BottomTabCollectionViewClickHandler, CarouselPageViewControllerDelegate {
    @IBOutlet weak var vwContainer: UIView!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var bottomTabCollectionView: BottomTabCollectionView!

    var carouselPageViewController: CarouselPageViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        bottomTabCollectionView.delegate = self
    }

    @IBAction func onButtonNextTap(_ sender: Any) {
        // perform action
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? CarouselPageViewController {
            carouselPageViewController = viewController
            carouselPageViewController?.carouselDelegate = self
            bottomTabCollectionView.setSelectedIndex(index: carouselPageViewController?.currentPageIndex ?? 0)
        }
    }

    func setViewController(index: Int) {
        carouselPageViewController?.setCurrentIndex(index: index)
    }

    func setCollectionPageIndex(index: Int) {
        bottomTabCollectionView.setSelectedIndex(index: carouselPageViewController?.currentPageIndex ?? 0)
    }

}

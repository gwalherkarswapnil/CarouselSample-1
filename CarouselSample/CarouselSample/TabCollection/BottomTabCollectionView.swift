//
//  BottomTabCollectionView.swift
//  PageViewWithUnderScoreTabs
//
//  Created by macmini41 on 14/10/22.
//

import UIKit

protocol BottomTabCollectionViewClickHandler {
    func setViewController(index: Int)
}

class BottomTabCollectionView: UIView {
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var tabCollectionView: UICollectionView!
    var delegate: BottomTabCollectionViewClickHandler?
    private var selectedIndex = -1
    var numberOfPages: Int = 5
    var interItemSpacing: Int = 10
    var heightOfTabs: Int = 20

    override init(frame: CGRect) {
        super.init(frame: frame)
        initWithNIB()

    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initWithNIB()
    }

    convenience init(titleText: String, background: UIColor) {
        self.init()
        contentView.backgroundColor = background
        initWithNIB()
    }

    private func initWithNIB() {
        Bundle.main.loadNibNamed("BottomTabCollectionView", owner: self, options: nil)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(contentView)
        tabCollectionView.register(UINib(nibName: "TabCollectionCell", bundle: nil), forCellWithReuseIdentifier: "TabCollectionCell")
        tabCollectionView.delegate = self
        tabCollectionView.dataSource = self
    }
}

extension BottomTabCollectionView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfPages
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TabCollectionCell", for: indexPath) as? TabCollectionCell else { return UICollectionViewCell() }
        if selectedIndex == indexPath.row {
            cell.selectedView.isHidden = false
            cell.unselectedView.isHidden = true

        } else {
            cell.selectedView.isHidden = true
            cell.unselectedView.isHidden = false
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(interItemSpacing)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width - 100
        return CGSize(width: screenWidth/CGFloat(numberOfPages), height: 20)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        tabCollectionView.reloadData()
        delegate?.setViewController(index: indexPath.row)
    }

    func reloadCollectioView () {
        tabCollectionView.reloadData()
    }

    func setSelectedIndex (index: Int) {
        selectedIndex = index
        tabCollectionView.reloadData()
    }
}

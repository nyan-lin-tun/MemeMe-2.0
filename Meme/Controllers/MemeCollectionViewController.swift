//
//  MemeCollectionViewController.swift
//  Meme
//
//  Created by Nyan Lin Tun on 08/04/2020.
//  Copyright © 2020 Nyan Lin Tun. All rights reserved.
//

import UIKit

class MemeCollectionViewController: UICollectionViewController {

    var count: Int = 0
    
    @IBOutlet weak var memeCollectionViewFlowLayout: UICollectionViewFlowLayout!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpNavigationItems()
        self.setUpFlowLayout()
        
    }

    private func setUpFlowLayout() {
        let space: CGFloat = 4
        // Multiply with 4 (2 for spacing between 3 cells and another 2 for left and right spacing)
        let dimession: CGFloat = (self.view.frame.size.width - (space * 4)) / 3.0
        memeCollectionViewFlowLayout.minimumLineSpacing = 4
        memeCollectionViewFlowLayout.minimumInteritemSpacing = 4
        memeCollectionViewFlowLayout.itemSize = CGSize(width: dimession, height: dimession)
        memeCollectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
    }
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let memeCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "memeCollectionViewCell", for: indexPath) as! MemeCollectionViewCell
        memeCollectionCell.backgroundColor = .blue
        memeCollectionCell.memeImage.image = UIImage(named: "wow")
        
        return memeCollectionCell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

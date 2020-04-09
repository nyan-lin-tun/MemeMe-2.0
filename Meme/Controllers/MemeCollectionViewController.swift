//
//  MemeCollectionViewController.swift
//  Meme
//
//  Created by Nyan Lin Tun on 08/04/2020.
//  Copyright © 2020 Nyan Lin Tun. All rights reserved.
//

import UIKit

class MemeCollectionViewController: UICollectionViewController {
    
    @IBOutlet weak var memeCollectionViewFlowLayout: UICollectionViewFlowLayout!
    
    override func viewWillAppear(_ animated: Bool) {
        self.collectionView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.collectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Sent Memes"
        self.setUpNavigationItems()
        self.setUpFlowLayout()
        self.checkMemeDataAlert(memes: memes)
        
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
        return memes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let memeCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "memeCollectionViewCell", for: indexPath) as! MemeCollectionViewCell
        memeCollectionCell.backgroundColor = .blue
        memeCollectionCell.memeImage.image = memes[indexPath.row].memeImage
        
        return memeCollectionCell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let memeDetailVC = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        memeDetailVC.modalPresentationStyle = .fullScreen
        memeDetailVC.meme = memes[indexPath.row]
        self.navigationController?.pushViewController(memeDetailVC, animated: true)
    }
}

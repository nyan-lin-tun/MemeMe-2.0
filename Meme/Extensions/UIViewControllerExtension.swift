//
//  UIViewControllerExtension.swift
//  Meme
//
//  Created by Nyan Lin Tun on 09/04/2020.
//  Copyright © 2020 Nyan Lin Tun. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func setUpNavigationItems() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.openMemeEditorAction))
    }

    @objc func openMemeEditorAction() {
        let memeEditorVC = self.storyboard!.instantiateViewController(withIdentifier: "MemeEditorViewController") as! MemeEditorViewController
        memeEditorVC.modalPresentationStyle = .fullScreen
        self.present(memeEditorVC, animated: true, completion: nil)
    }
    
    func setUpEditNavigationItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(self.openMemeEditorAction))
    }
    
    @objc func editOnMemeEditorAction() {
        let memeEditorVC = self.storyboard!.instantiateViewController(withIdentifier: "MemeEditorViewController") as! MemeEditorViewController
        memeEditorVC.modalPresentationStyle = .fullScreen
        self.present(memeEditorVC, animated: true, completion: nil)
    }

}

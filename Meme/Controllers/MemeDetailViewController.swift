//
//  MemeDetailViewController.swift
//  Meme
//
//  Created by Nyan Lin Tun on 09/04/2020.
//  Copyright © 2020 Nyan Lin Tun. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
    
    
    @IBOutlet weak var memeImage: UIImageView!
    
    var meme: Meme?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.memeImage.image = meme?.memeImage
    }

}

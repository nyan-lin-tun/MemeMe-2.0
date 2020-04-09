//
//  Meme.swift
//  Meme
//
//  Created by Nyan Lin Tun on 05/04/2020.
//  Copyright © 2020 Nyan Lin Tun. All rights reserved.
//

import Foundation
import UIKit

struct Meme {
    let topText: String
    let bottomText: String
    let originalImage: UIImage
    let memeImage: UIImage
       
    static func saveMeme(meme: Meme) {
        self.storeToSharedModel(meme)
        UIImageWriteToSavedPhotosAlbum(meme.memeImage, self, nil, nil)
        
    }
    
    static func storeToSharedModel(_ meme: Meme) {
        memes.append(meme)
    }
}

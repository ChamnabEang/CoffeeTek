//
//  CollectionViewCell.swift
//  CoffeeTek
//
//  Created by Chamnab Eang on 26/2/21.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var slideImage: UIImageView!
    var image: UIImage!{
        didSet{
            slideImage.image = image
        }
    }
}

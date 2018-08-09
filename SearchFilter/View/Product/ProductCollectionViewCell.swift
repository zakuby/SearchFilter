//
//  ProductCollectionViewCell.swift
//  SearchFilter
//
//  Created by Muhammad Yaqub on 08/08/18.
//  Copyright © 2018 MiniProject. All rights reserved.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UITextView!
    @IBOutlet weak var price: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        name.isEditable = false
        name.isSelectable = false
        name.isUserInteractionEnabled = false
        name.textContainer.maximumNumberOfLines = 2
        name.textContainer.lineBreakMode = .byTruncatingTail
        // Initialization code
    }

}

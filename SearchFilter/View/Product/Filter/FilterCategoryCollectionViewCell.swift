//
//  FilterCategoryCollectionViewCell.swift
//  SearchFilter
//
//  Created by Muhammad Yaqub on 09/08/18.
//  Copyright © 2018 MiniProject. All rights reserved.
//

import UIKit

class FilterCategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderWidth = 1
        layer.borderColor = UIColor(red: 125/255, green: 125/255, blue: 125/255, alpha: 1).cgColor
        layer.cornerRadius = layer.frame.height / 2
        closeButton.layer.cornerRadius = layer.frame.height / 2
        closeButton.layer.borderWidth = 1
        closeButton.layer.borderColor = UIColor(red: 125/255, green: 125/255, blue: 125/255, alpha: 1).cgColor
        // Initialization code
    }

}

//
//  ShopCategoryTableViewCell.swift
//  SearchFilter
//
//  Created by Muhammad Yaqub on 11/08/18.
//  Copyright © 2018 MiniProject. All rights reserved.
//

import UIKit

class ShopCategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var status: UIView!
    @IBOutlet weak var name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        status.layer.borderWidth = 1
        status.layer.borderColor = UIColor(red: 125/255, green: 125/255, blue: 125/255, alpha: 1).cgColor
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func switchView(status: Bool){
        if(status){
            self.status.layer.backgroundColor = UIColor(red: 36/255, green: 168/255, blue: 32/255, alpha: 1).cgColor
        }else{
            self.status.layer.backgroundColor = UIColor(white: 1, alpha: 1).cgColor
        }
    }
}

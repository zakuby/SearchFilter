//
//  ShopTypeTableView.swift
//  SearchFilter
//
//  Created by Muhammad Yaqub on 11/08/18.
//  Copyright © 2018 MiniProject. All rights reserved.
//

import UIKit

extension ShopTypeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return category.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShopCategoryTableViewCell", for: indexPath) as! ShopCategoryTableViewCell
        
        cell.name.text = category[indexPath.item].name
        cell.switchView(status: category[indexPath.item].status)
        
        if category[indexPath.item].name == "Gold Merchant"{
            if category[indexPath.item].status{
                MainViewController.fshop = 2
            }else{
                MainViewController.fshop = 0
            }
            
        }else if category[indexPath.item].name == "Official Store"{
            MainViewController.official = category[indexPath.item].status
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        category[indexPath.item].status = !category[indexPath.item].status
        
        categoryList.reloadData()
    }
}

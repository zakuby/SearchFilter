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
        
        cell.name.text = category[indexPath.item]
        cell.switchView(status: selectedCategory[indexPath.item])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCategory[indexPath.item] = !selectedCategory[indexPath.item]
        if selectedCategory[indexPath.item]{
            filteredCategory.append(category[indexPath.item])
        }else{
            filteredCategory.filter{ !category[indexPath.item].contains($0)}
        }
        categoryList.reloadData()
    }
}

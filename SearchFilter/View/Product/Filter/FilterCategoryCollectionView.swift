//
//  FilterCategoryCollectionView.swift
//  SearchFilter
//
//  Created by Muhammad Yaqub on 09/08/18.
//  Copyright © 2018 MiniProject. All rights reserved.
//

import UIKit

extension FilterViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return category.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterCategoryCollectionViewCell", for: indexPath) as! FilterCategoryCollectionViewCell
        
        cell.name.text = category[indexPath.item]
        cell.closeButton.tag = indexPath.item
        cell.closeButton.addTarget(self, action: #selector(deleteCell(sender:)), for: .touchUpInside)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 156 , height:  40)
    }
    
    @objc func deleteCell(sender: UIButton) {
        category.remove(at: sender.tag)
        categoryList.reloadData()
    }
    
    
}

//
//  MainProductCollectionView.swift
//  SearchFilter
//
//  Created by Muhammad Yaqub on 08/08/18.
//  Copyright © 2018 MiniProject. All rights reserved.
//

import UIKit
import Kingfisher

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell", for: indexPath) as! ProductCollectionViewCell
        
        if products[indexPath.item].image_uri != nil && products[indexPath.item].image_uri != "" {
            let urlImg = URL(string: products[indexPath.item].image_uri!)
            cell.image.kf.setImage(with: urlImg, options: [.forceRefresh])
        }
        
        cell.name.text = products[indexPath.item].name
        cell.price.text = products[indexPath.item].price
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
        return CGSize(width: productList.frame.width/2 - 4 , height:  productList.frame.width * 0.8 )
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if (indexPath.item == products.count - 1 ) {
            contentIsLoading = true
            self.loadingImage.isHidden = false
            loadList()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let webViewController = WebViewController(nibName: "WebViewController", bundle: nil)
        webViewController.webUrl = products[indexPath.item].uri ?? ""
        self.navigationController?.pushViewController(webViewController, animated: true)
    }
    
}

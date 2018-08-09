//
//  ViewController.swift
//  SearchFilter
//
//  Created by Muhammad Yaqub on 08/08/18.
//  Copyright © 2018 MiniProject. All rights reserved.
//

import UIKit
import ObjectMapper

class MainViewController: UIViewController {

    @IBOutlet weak var productList: UICollectionView!

    @IBOutlet var loadingImage: UIImageView!
    
    var contentIsLoading = false
    
    var page = 0
    var limit      = 10
    
    var products = [Product]()
    
    @IBAction func filterPressed(_ sender: Any) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rotateView(targetView: loadingImage)
        
        
        productList.showsVerticalScrollIndicator = false
        productList.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProductCollectionViewCell")
        
        productList.delegate = self
        productList.dataSource = self
        self.page = 0
        LoadingOverlay.shared.showOverlay()
        loadList()
    }
    
    func loadList(){
        APIHandler().getProduct(offset: self.limit * self.page, limit: self.limit) { (resp) in
            if self.page == 0{
                LoadingOverlay.shared.hideOverlay()
            }else{
                self.loadingImage.isHidden = true
            }
            self.contentIsLoading = false
            self.page += 1
            if let products = Mapper<Product>().mapArray(JSONObject: resp.data?.arrayObject){
                self.products.append(contentsOf: products)
                self.productList.reloadData()
            }
        }
    }
    
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        
//        let bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height;
//        if (bottomEdge >= scrollView.contentSize.height && contentIsLoading == false) {
//            contentIsLoading = true
//            self.loadingImage.isHidden = false
//            self.loadList()
//        }
//    }
    
    func rotateView(targetView: UIView, duration: Double = 2.0) {
        UIView.animate(withDuration: duration, delay: 0.0, options: .curveLinear, animations: {
            targetView.transform = targetView.transform.rotated(by: .pi)
        }) { finished in
            self.rotateView(targetView: targetView, duration: duration)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


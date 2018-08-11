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
    
    public static var pmin : String? = "100"
    public static var pmax : String? = "7000000"
    public static var wholesale : Bool? = true
    public static var official : Bool? = true
    public static var fshop : Int? = 2
    public static var isFilter : Bool? = false
    
    public static func resetValue(){
        MainViewController.pmin = "100"
        MainViewController.pmax = "7000000"
        MainViewController.wholesale = true
        MainViewController.official = true
        MainViewController.fshop = 2
        MainViewController.isFilter = false
    }
    
    var contentIsLoading = false
    
    var page = 0
    var limit = 10
    
    var products = [Product]()
    @IBAction func filterPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "FilterViewController") as! FilterViewController
        present(vc, animated: true)
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        if MainViewController.isFilter!{
            self.page = 0
            LoadingOverlay.shared.showOverlay()
            self.products = [Product]()
            loadList()
        }
    }
    
    func loadList(){
        let vc = MainViewController.self
        ProductService().getProduct(offset: self.limit * self.page, limit: self.limit, pmin: vc.pmin!, pmax: vc.pmax!, wholesale: vc.wholesale!, official: vc.official!, fshop: vc.fshop!) { (resp) in
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


//
//  ShopTypeViewController.swift
//  SearchFilter
//
//  Created by Muhammad Yaqub on 11/08/18.
//  Copyright © 2018 MiniProject. All rights reserved.
//

import UIKit

class ShopTypeViewController: UIViewController {

    var category = ["Gold Merchant", "Official Store"]
    var filteredCategory = [String]()
    var selectedCategory = [false, false]
    
    @IBOutlet weak var categoryList: UITableView!
    
    @IBAction func closeTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func applyPressed(_ sender: Any) {
        MainViewController.official = filteredCategory.contains("Official Store")
        if filteredCategory.contains("Gold Merchant"){
            MainViewController.fshop = 2
        }else{
            MainViewController.fshop = 0
        }
        dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var resetTapped: UIButton!
    
    
    var filterTypeApplied : (([String]) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoryList.delegate = self
        categoryList.dataSource = self
        categoryList.separatorStyle = .none
        categoryList.register(UINib(nibName: "ShopCategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "ShopCategoryTableViewCell")
        categoryList.rowHeight = UITableViewAutomaticDimension
        categoryList.estimatedRowHeight = 50.0
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

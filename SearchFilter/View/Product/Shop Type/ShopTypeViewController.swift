//
//  ShopTypeViewController.swift
//  SearchFilter
//
//  Created by Muhammad Yaqub on 11/08/18.
//  Copyright © 2018 MiniProject. All rights reserved.
//

import UIKit

class CategoryType: NSObject{
    var name: String = ""
    var status: Bool = false
    
    init(name: String, status: Bool) {
        self.name = name
        self.status = status
    }
}

class ShopTypeViewController: UIViewController {

    var category = [CategoryType]()
    var filteredCategory = [String]()
    
    @IBOutlet weak var categoryList: UITableView!
    
    @IBAction func closeTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func applyPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func resetTapped(_ sender: Any) {
        for (_, item) in category.enumerated(){
            item.status = false
        }
        categoryList.reloadData()
    }
    
    
    var filterTypeApplied : (([String]) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoryList.delegate = self
        categoryList.dataSource = self
        categoryList.separatorStyle = .none
        categoryList.register(UINib(nibName: "ShopCategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "ShopCategoryTableViewCell")
        categoryList.rowHeight = UITableViewAutomaticDimension
        categoryList.estimatedRowHeight = 60.0
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        category.removeAll()
        if MainViewController.official!{
            category.append(CategoryType(name: "Official Store", status: true))
        }else{
            category.append(CategoryType(name: "Official Store", status: false))
        }
        
        if MainViewController.fshop == 2{
            category.append(CategoryType(name: "Gold Merchant", status: true))
        }else{
            category.append(CategoryType(name: "Gold Merchant", status: false))
        }
        categoryList.reloadData()
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

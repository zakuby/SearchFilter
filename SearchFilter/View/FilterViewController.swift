//
//  FilterViewController.swift
//  SearchFilter
//
//  Created by Muhammad Yaqub on 09/08/18.
//  Copyright © 2018 MiniProject. All rights reserved.
//

import UIKit
import RangeSeekSlider

class FilterViewController: UIViewController, RangeSeekSliderDelegate {

    @IBOutlet weak var wholeSaleSwitcher: UISwitch!
    @IBOutlet weak var maximumPrice: UILabel!
    @IBOutlet weak var minimumPrice: UILabel!
    func rangeSeekSlider(_ slider: RangeSeekSlider, didChange minValue: CGFloat, maxValue: CGFloat) {
        minimumPrice.text = "Rp " + Int(minValue).formattedWithSeparator
        maximumPrice.text = "Rp " + Int(maxValue).formattedWithSeparator
    }
    
    @IBAction func closeTapped(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func resetTapped(_ sender: Any) {
        MainViewController.resetValue()
        reloadFilter()
    }
    
    @IBAction func applyTapped(_ sender: Any) {
        MainViewController.isFilter = true
        MainViewController.pmin = String(Int(rangeSlider.selectedMinValue))
        MainViewController.pmax = String(Int(rangeSlider.selectedMaxValue))
        MainViewController.wholesale = wholeSaleSwitcher.isOn
        MainViewController.official = category.contains("Official Store")
        if category.contains("Gold Merchant"){
            MainViewController.fshop = 2
        }else{
            MainViewController.fshop = 0
        }
        dismiss(animated: true)
    }
    
    @IBAction func filterTapped(_ sender: Any){
        let pvc : ShopTypeViewController = ShopTypeViewController(nibName: "ShopTypeViewController", bundle: nil)
        show(pvc, sender: self)
    }
    
    
    @IBOutlet weak var rangeSlider: RangeSeekSlider!
    
    var category = [String]()
    @IBOutlet weak var categoryList: UICollectionView!
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.isHidden = true
        rangeSlider.delegate = self
        
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        categoryList.showsHorizontalScrollIndicator = false
        categoryList.register(UINib(nibName: "FilterCategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FilterCategoryCollectionViewCell")
        
        categoryList.delegate = self
        categoryList.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        reloadFilter()
    }
    
    func reloadFilter(){
        rangeSlider.selectedMinValue = CGFloat((MainViewController.pmin! as NSString).doubleValue)
        rangeSlider.minValue = rangeSlider.minValue
        rangeSlider.selectedMaxValue = CGFloat((MainViewController.pmax! as NSString).doubleValue)
        rangeSlider.maxValue = rangeSlider.maxValue
        wholeSaleSwitcher.isOn = MainViewController.wholesale!
        category.removeAll()
        if MainViewController.official!{
            category.append("Official Store")
        }else{
            category.filter{ !"Official Store".contains($0)}
        }
        
        if MainViewController.fshop == 2{
            category.append("Gold Merchant")
        }else{
            category.filter{ !"Gold Merchant".contains($0)}
        }
        categoryList.reloadData()
        minimumPrice.text = "Rp " + Int(rangeSlider.selectedMinValue).formattedWithSeparator
        maximumPrice.text = "Rp " + Int(rangeSlider.selectedMaxValue).formattedWithSeparator
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

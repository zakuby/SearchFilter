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

    @IBOutlet weak var maximumPrice: UILabel!
    @IBOutlet weak var minimumPrice: UILabel!
    func rangeSeekSlider(_ slider: RangeSeekSlider, didChange minValue: CGFloat, maxValue: CGFloat) {
        minimumPrice.text = "Rp " + Int(minValue).formattedWithSeparator
        maximumPrice.text = "Rp " + Int(maxValue).formattedWithSeparator
    }
    
    @IBOutlet weak var rangeSlider: RangeSeekSlider!
    
    var category = ["Gold Merchant", "Official Store"]
    @IBOutlet weak var categoryList: UICollectionView!
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.isHidden = true
        rangeSlider.delegate = self
        
        minimumPrice.text = "Rp " + Int(rangeSlider.selectedMinValue).formattedWithSeparator
        maximumPrice.text = "Rp " + Int(rangeSlider.selectedMaxValue).formattedWithSeparator
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        categoryList.showsHorizontalScrollIndicator = false
        categoryList.register(UINib(nibName: "FilterCategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FilterCategoryCollectionViewCell")
        
        categoryList.delegate = self
        categoryList.dataSource = self
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

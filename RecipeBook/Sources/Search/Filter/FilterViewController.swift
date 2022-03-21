//
//  FilterViewController.swift
//  RecipeBook
//
//  Created by Serik Musaev on 3/21/22.
//

import Foundation
import UIKit

class FilterViewController: CViewController<FilterView> {
    
    private let cuisines = [
        "African","American","British",
        "Cajun","Caribbean","Chinese",
        "Eastern European","European",
        "French","German","Greek",
        "Indian","Irish","Italian",
        "Japanese","Jewish","Korean",
        "Latin American",
        "Mediterranean","Mexican","Middle Eastern",
        "Nordic","Southern","Spanish",
        "Thai","Vietnamese"
    ]
    
    private var parameters: FilterParameters = FilterParameters()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Filters"
        navigationItem.hidesBackButton = true
        customView.pickerView.dataSource = self
        customView.pickerView.delegate = self
    }
    
    func getFilterParamters() -> FilterParameters {
        parameters
    }
}

extension FilterViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        cuisines.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        cuisines[row]
    }
}

extension FilterViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if let textField = customView.cuisineFieldContainer.subviews.first as? UITextField {
            parameters.cuisine = cuisines[row]
            textField.text = parameters.cuisine
        }
    }
}

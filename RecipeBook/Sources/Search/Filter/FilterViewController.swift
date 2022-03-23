//
//  FilterViewController.swift
//  RecipeBook
//
//  Created by Serik Musaev on 3/21/22.
//

import Foundation
import UIKit
import TagListView

class FilterViewController: CViewController<FilterView> {
    
    private let cuisines = [
        "Any","African","American","British",
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
    
    private let diets = [
        "None","Gluten Free","Ketogenic","Vegetarian",
        "Lacto-Vegetarian","Ovo-Vegetarian","Vegan",
        "Pescetarian","Paleo","Primal","Low FODMAP","Whole30",
    ]
    
    private var parameters: FilterParameters = FilterParameters()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Filters"
        navigationItem.hidesBackButton = true
        customView.cuisinePicker.dataSource = self
        customView.cuisinePicker.delegate = self
        
        customView.dietPicker.dataSource = self
        customView.dietPicker.delegate = self
        
        customView.intolerances.delegate = self
    }
    
    func getFilterParameters() -> FilterParameters {
        parameters.intolerances = []
        for intolerance in customView.intolerances.selectedTags() {
            if let title = intolerance.currentTitle {
                parameters.intolerances.append(title)
            }
        }
        print(parameters.intolerances)
        return parameters
    }
}

extension FilterViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == customView.cuisinePicker {
            return cuisines.count
        }
        return diets.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == customView.cuisinePicker {
            return cuisines[row]
        }
        return diets[row]
    }
}

extension FilterViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == customView.cuisinePicker {
            if let textField = customView.cuisineFieldContainer.subviews.first as? FilterTextField {
                if cuisines[row] == "Any" {
                    textField.text = cuisines[row]
                    parameters.cuisine = nil
                } else {
                    parameters.cuisine = cuisines[row]
                    textField.text = parameters.cuisine
                }
            }
        } else {
            if let textField = customView.dietFieldContainer.subviews.first as? FilterTextField {
                if diets[row] == "None" {
                    textField.text = diets[row]
                    parameters.diet = nil
                } else {
                    parameters.diet = diets[row]
                    textField.text = parameters.diet
                }
            }
        }
    }
}

extension FilterViewController: TagListViewDelegate {
    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        print("Pressed tag: \(title)")
        tagView.isSelected.toggle()
    }
}

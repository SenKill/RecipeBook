//
//  CViewController.swift
//  RecipeBook
//
//  Created by Serik Musaev on 2/13/22.
//

import Foundation
import UIKit

// MARK: - CustomViewController
class CViewController<V: CView>: UIViewController {
    
    override func loadView() {
        view = V()
    }
    
    // To access view use this computed property
    var customView: V {
        view as! V
    }
}

//
//  FilterTextField.swift
//  RecipeBook
//
//  Created by Serik Musaev on 3/22/22.
//

import Foundation
import UIKit

class FilterTextField: UITextField {
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        false
    }
    
    override func selectionRects(for range: UITextRange) -> [UITextSelectionRect] {
        []
    }
    
    override func caretRect(for position: UITextPosition) -> CGRect {
        .null
    }
}

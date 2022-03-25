//
//  UILabel.swift
//  RecipeBook
//
//  Created by Serik Musaev on 3/25/22.
//

import Foundation
import UIKit

extension UILabel {
    func setLabelWithIcon(_ icon: UIImage, text: String) {
        let iconAttachment = NSTextAttachment()
        iconAttachment.image = icon
        
        let iconOffsetY: CGFloat = -5.0
        iconAttachment.bounds = CGRect(x: 0, y: iconOffsetY, width: iconAttachment.image!.size.width, height: iconAttachment.image!.size.height)
        
        let completeText = NSMutableAttributedString(string: "")
        
        let attachmentString = NSAttributedString(attachment: iconAttachment)
        completeText.append(attachmentString)
        let textAfterIcon = NSAttributedString(string: text)
        completeText.append(textAfterIcon)
        
        self.textAlignment = .center
        self.attributedText = completeText
    }
}

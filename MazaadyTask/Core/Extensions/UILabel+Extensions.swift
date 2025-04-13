//
//  UILabel+Extensions.swift
//  MazaadyTask
//
//  Created by Mohamed Saad on 13/04/2025.
//

import Foundation
import UIKit

extension UILabel {
    func setStrikethroughText(_ text: String, color: UIColor = .red, font: UIFont? = nil) {
        let attributes: [NSAttributedString.Key: Any] = [
            .strikethroughStyle: NSUnderlineStyle.single.rawValue,
            .strikethroughColor: color,
            .foregroundColor: color,
            .font: font ?? self.font ?? UIFont.systemFont(ofSize: 17)
        ]
        
        let attributedString = NSAttributedString(string: text, attributes: attributes)
        self.attributedText = attributedString
    }
}

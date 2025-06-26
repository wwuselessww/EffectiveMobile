//
//  UILabel+Extensions.swift
//  EffectiveMobile
//
//  Created by Alexander Kozharin on 26.06.25.
//

import UIKit

extension UILabel {
    func setStrikethrough(shouldStrike: Bool) {
        guard let text = self.text else { return }

        let attributes: [NSAttributedString.Key: Any]
        if shouldStrike {
            attributes = [
                .strikethroughStyle: NSUnderlineStyle.single.rawValue,
                .foregroundColor: UIColor.systemGray2
            ]
        } else {
            attributes = [
                .strikethroughStyle: 0,
                .foregroundColor: self.textColor ?? UIColor.label
            ]
        }

        let attributedString = NSAttributedString(string: text, attributes: attributes)
        self.attributedText = attributedString
    }
}

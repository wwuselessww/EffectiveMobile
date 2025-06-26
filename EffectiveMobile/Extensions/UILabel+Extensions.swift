//
//  UILabel+Extensions.swift
//  EffectiveMobile
//
//  Created by Alexander Kozharin on 26.06.25.
//

import UIKit

extension UILabel {
    func setStrikethrough(shouldStrike: Bool) {
        if shouldStrike {
            let attributedString = NSAttributedString(
                string: self.text ?? "",
                attributes: [
                    .strikethroughStyle: NSUnderlineStyle.single.rawValue,
                    .foregroundColor: UIColor.systemGray2
                ]
            )
            self.attributedText = attributedString
        } else {
            self.attributedText = NSAttributedString(string: self.text ?? "")
        }
    }
}

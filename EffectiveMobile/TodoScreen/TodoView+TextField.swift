//
//  TodoView+TextField.swift
//  EffectiveMobile
//
//  Created by Alexander Kozharin on 23.06.25.
//

import UIKit

extension TodoView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}


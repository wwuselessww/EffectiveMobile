//
//  TodoView+TextView.swift
//  EffectiveMobile
//
//  Created by Alexander Kozharin on 24.06.25.
//

import UIKit

extension TodoView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray  && textView.text == presenter?.textViewPlaceholder {
            textView.text = nil
            textView.textColor = .label
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = presenter?.textViewPlaceholder
            if textView.text == presenter?.textViewPlaceholder {
                textView.textColor = .lightGray
            } else {
                textView.textColor = .label
            }
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
           if(text == "\n") {
               textView.resignFirstResponder()
               return false
           }
           return true
       }
}

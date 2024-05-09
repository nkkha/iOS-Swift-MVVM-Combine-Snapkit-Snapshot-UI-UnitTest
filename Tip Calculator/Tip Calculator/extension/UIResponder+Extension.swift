//
//  UIResponder+Extension.swift
//  Tip Calculator
//
//  Created by nkkha on 9/5/24.
//

import UIKit

extension UIResponder {
    var parentViewController: UIViewController? {
        return self.next as? UIViewController ?? self.next?.parentViewController
    }
}

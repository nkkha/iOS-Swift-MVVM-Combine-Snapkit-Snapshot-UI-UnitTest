//
//  Double+Extension.swift
//  Tip Calculator
//
//  Created by nkkha on 9/5/24.
//

import Foundation

extension Double {
    var stringValue: String? {
        String(self)
    }
    
    var currencyFormatted: String {
        var isWholeNumber: Bool {
            isZero ? true : (!isNormal ? false : self == rounded())
        }
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "en_US")
        formatter.minimumFractionDigits = isWholeNumber ? 0 : 2
        return formatter.string(for: self) ?? ""
    }
}

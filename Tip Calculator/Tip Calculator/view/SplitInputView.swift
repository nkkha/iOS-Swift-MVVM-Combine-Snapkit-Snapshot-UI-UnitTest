//
//  SplitInputView.swift
//  Tip Calculator
//
//  Created by nkkha on 7/5/24.
//

import UIKit

class SplitInputView: UIView {
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        backgroundColor = .yellow
    }
}

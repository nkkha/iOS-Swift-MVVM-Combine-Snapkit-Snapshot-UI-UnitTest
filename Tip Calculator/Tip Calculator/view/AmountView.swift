//
//  AmountView.swift
//  Tip Calculator
//
//  Created by nkkha on 8/5/24.
//

import UIKit

class AmountView: UIView {
    private var title: String
    private var amount: Int
    private var textAlignment: NSTextAlignment
    
    init(title: String, amount: Int, textAlignment: NSTextAlignment) {
        self.title = title
        self.amount = amount
        self.textAlignment = textAlignment
        super.init(frame: .zero)
        layout()
    }
    
    private lazy var titleLabel: UILabel = {
        LabelFactory.build(text: title, font: ThemeFont.regular(ofSize: 18), textColor: ThemeColor.text, textAlignment: textAlignment)
    }()
    
    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        let text = NSMutableAttributedString(string: "$\(amount)", attributes: [.font: ThemeFont.bold(ofSize: 24)])
        text.addAttributes([.font: ThemeFont.bold(ofSize: 16)], range: NSMakeRange(0, 1))
        label.attributedText = text
        label.textColor = ThemeColor.primary
        label.textAlignment = textAlignment
        return label
    }()
    
    private lazy var vStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            titleLabel,
            amountLabel
        ])
        view.axis = .vertical
        view.spacing = -4
        return view
    }()

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        addSubview(vStackView)
        
        vStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

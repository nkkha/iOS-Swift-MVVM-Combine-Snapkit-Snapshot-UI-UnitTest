//
//  TipInputView.swift
//  Tip Calculator
//
//  Created by nkkha on 7/5/24.
//

import UIKit

class TipInputView: UIView {
    private let headerView: HeaderView = {
        let view = HeaderView()
        view.configure(topLabel: "Choose", bottomLabel: "your tip")
        return view
    }()
    
    private lazy var tenPercentButton: UIButton = {
        let button = buildTipButton(tip: .tenPercent)
        return button
    }()
    
    private lazy var fifteenPercentButton: UIButton = {
        let button = buildTipButton(tip: .fifteenPercent)
        return button
    }()
    
    private lazy var twentyPercentButton: UIButton = {
        let button = buildTipButton(tip: .twentyPercent)
        return button
    }()
    
    private lazy var customButton: UIButton = {
        let button = UIButton()
        button.setTitle("Custom tip", for: .normal)
        button.backgroundColor = ThemeColor.primary
        button.tintColor = .white
        button.titleLabel?.font = ThemeFont.bold(ofSize: 20)
        button.addCornerRadius(radius: 8)
        return button
    }()
    
    private lazy var buttonHStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            tenPercentButton,
            fifteenPercentButton,
            twentyPercentButton
        ])
        view.axis = .horizontal
        view.spacing = 16
        view.distribution = .fillEqually
        return view
    }()
    
    private lazy var buttonVStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            buttonHStackView,
            customButton
        ])
        view.axis = .vertical
        view.spacing = 16
        view.distribution = .fillEqually
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        [headerView, buttonVStackView].forEach(addSubview(_:))
        
        headerView.snp.makeConstraints { make in
            make.width.equalTo(68)
            make.leading.equalToSuperview()
            make.top.equalTo(snp.top).offset(4)
            make.trailing.equalTo(buttonVStackView.snp.leading).offset(-24)
        }
        
        buttonVStackView.snp.makeConstraints { make in
            make.top.trailing.bottom.equalToSuperview()
        }
    }
    
    private func buildTipButton(tip: Tip) -> UIButton {
        let button = UIButton(type: .custom)
        button.backgroundColor = ThemeColor.primary
        button.tintColor = .white
        let text = NSMutableAttributedString(string: tip.stringValue, attributes: [
            .font: ThemeFont.bold(ofSize: 20),
            .foregroundColor: UIColor.white
        ])
        text.addAttributes([.font: ThemeFont.demibold(ofSize: 14)], range: NSMakeRange(tip.stringValue.count - 1, 1))
        button.setAttributedTitle(text, for: .normal)
        button.addCornerRadius(radius: 8)
        return button
    }
}

//
//  BillInputView.swift
//  Tip Calculator
//
//  Created by nkkha on 7/5/24.
//

import UIKit

class BillInputView: UIView {
    private let headerView: HeaderView = {
        let view = HeaderView()
        view.configure(topLabel: "Enter", bottomLabel: "your bill")
        return view
    }()
    
    private let currencyLabel: UILabel = {
        let label = LabelFactory.build(text: "$", font: ThemeFont.bold(ofSize: 24))
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.textColor = ThemeColor.text
        textField.font = ThemeFont.demibold(ofSize: 28)
        textField.keyboardType = .decimalPad
        textField.setContentHuggingPriority(.defaultLow, for: .horizontal)
        // Add toolbar
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: 36))
        toolbar.barStyle = .default
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(
            title: "Done",
            style: .plain,
            target: self,
            action: #selector(doneButtonTapped))
        toolbar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            doneButton
        ]
        toolbar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolbar
        return textField
    }()
    
    private let textFieldContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.addCornerRadius(radius: 8)
        return view
    }()
    
    private
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        [headerView, textFieldContainerView].forEach(addSubview(_:))
        
        headerView.snp.makeConstraints { make in
            make.width.equalTo(68)
            make.leading.equalToSuperview()
            make.centerY.equalTo(textFieldContainerView.snp.centerY)
            make.trailing.equalTo(textFieldContainerView.snp.leading).offset(-24)
        }
        
        textFieldContainerView.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview()
        }
        
        [currencyLabel, textField].forEach(textFieldContainerView.addSubview(_:))
        
        currencyLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(textFieldContainerView.snp.leading).offset(12)
            make.trailing.equalTo(textField.snp.leading).offset(-12)
        }
        
        textField.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview()
        }
    }
    
    @objc private func doneButtonTapped() {
        self.textField.endEditing(true)
    }
}

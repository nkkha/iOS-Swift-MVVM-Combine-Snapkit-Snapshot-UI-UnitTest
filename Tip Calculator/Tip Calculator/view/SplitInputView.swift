//
//  SplitInputView.swift
//  Tip Calculator
//
//  Created by nkkha on 7/5/24.
//

import UIKit

class SplitInputView: UIView {
    private let headerView: HeaderView = {
        let view = HeaderView()
        view.configure(topLabel: "Split", bottomLabel: "the total")
        return view
    }()
    
    private lazy var decrementButton: UIButton = {
        let button = UIButton()
        button.setTitle("-", for: .normal)
        button.backgroundColor = ThemeColor.primary
        button.tintColor = .white
        button.titleLabel?.font = ThemeFont.bold(ofSize: 20)
        button.addRoundedCorners(corners: [.layerMinXMinYCorner, .layerMinXMaxYCorner], radius: 8)
        return button
    }()
    
    private lazy var increaseButton: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.backgroundColor = ThemeColor.primary
        button.tintColor = .white
        button.titleLabel?.font = ThemeFont.bold(ofSize: 20)
        button.addRoundedCorners(corners: [.layerMaxXMinYCorner, .layerMaxXMaxYCorner], radius: 8)
        return button
    }()
    
    private lazy var quantityLabel: UILabel = {
        let label = LabelFactory.build(text: "1", font: ThemeFont.bold(ofSize: 20))
        label.backgroundColor = .white
        return label
    }()
    
    private lazy var hStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            decrementButton,
            quantityLabel,
            increaseButton
        ])
        view.axis = .horizontal
        view.spacing = 0
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
        [headerView, hStackView].forEach(addSubview(_:))
        
        headerView.snp.makeConstraints { make in
            make.width.equalTo(68)
            make.leading.equalToSuperview()
            make.centerY.equalTo(hStackView.snp.centerY)
            make.trailing.equalTo(hStackView.snp.leading).offset(-24)
        }
        
        hStackView.snp.makeConstraints { make in
            make.top.trailing.bottom.equalToSuperview()
        }
        
        [decrementButton, increaseButton].forEach { button in
            button.snp.makeConstraints { make in
                make.height.equalTo(button.snp.width)
            }
        }
    }
}

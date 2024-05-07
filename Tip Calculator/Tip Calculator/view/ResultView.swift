//
//  ResultView.swift
//  Tip Calculator
//
//  Created by nkkha on 7/5/24.
//

import UIKit

class ResultView: UIView {
    private let headerLabel: UILabel = {
        LabelFactory.build(text: "Total per person", font: ThemeFont.demibold(ofSize: 16))
    }()
    
    private let amountPerPersonLabel: UILabel = {
        let label = UILabel()
        let text = NSMutableAttributedString(string: "$000", attributes: [.font : ThemeFont.bold(ofSize: 36)])
        text.addAttributes([.font : ThemeFont.demibold(ofSize: 18)], range: NSMakeRange(0, 1))
        label.attributedText = text
        return label
    }()
    
    private let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = ThemeColor.seperator
        return view
    }()
    
    private lazy var vStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            headerLabel,
            amountPerPersonLabel,
            dividerView
        ])
        view.axis = .vertical
        view.spacing = 24
        view.alignment = .center
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
        backgroundColor = .white
        addSubview(vStackView)
        
        vStackView.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(24)
            make.bottom.equalTo(snp.bottom).offset(-24)
            make.leading.equalTo(snp.leading).offset(24)
            make.trailing.equalTo(snp.trailing).offset(-24)
        }
        
        dividerView.snp.makeConstraints { make in
            make.height.equalTo(2)
        }
        
        addShadow(offset: CGSize(width: 0, height: 3), color: ThemeColor.bg, radius: 12, opacity: 0.1)
    }
}

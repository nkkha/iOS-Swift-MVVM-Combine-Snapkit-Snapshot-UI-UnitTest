//
//  ResultView.swift
//  Tip Calculator
//
//  Created by nkkha on 7/5/24.
//

import UIKit

class ResultView: UIView {
    private let headerLabel: UILabel = {
        LabelFactory.build(text: "Total per person", font: ThemeFont.demibold(ofSize: 18))
    }()
    
    private let amountPerPersonLabel: UILabel = {
        let label = UILabel()
        let text = NSMutableAttributedString(string: "$0", attributes: [.font : ThemeFont.bold(ofSize: 36)])
        text.addAttributes([.font : ThemeFont.demibold(ofSize: 18)], range: NSMakeRange(0, 1))
        label.attributedText = text
        label.textAlignment = .center
        return label
    }()
    
    private let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = ThemeColor.seperator
        return view
    }()
    
    private let totalBillView: AmountView = {
        let view = AmountView(title: "Total bill", textAlignment: .left)
        return view
    }()
    
    private let totalTipView: AmountView = {
        let view = AmountView(title: "Total tip", textAlignment: .right)
        return view
    }()
    
    private lazy var hStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            totalBillView,
            totalTipView
        ])
        view.axis = .horizontal
        view.distribution = .fillEqually
        return view
    }()
    
    private lazy var vStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            headerLabel,
            amountPerPersonLabel,
            dividerView,
            buildSpacerView(height: 0),
            hStackView
        ])
        view.axis = .vertical
        view.spacing = 8
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
    
    private func buildSpacerView(height: CGFloat) -> UIView {
        let view = UIView()
        view.snp.makeConstraints { make in
            make.height.equalTo(height)
        }
        return view
    }
    
    func configure(result: Result) {
        let text = NSMutableAttributedString(string: result.amountPerPerson.currencyFormatted, attributes: [.font : ThemeFont.bold(ofSize: 36)])
        text.addAttributes([.font : ThemeFont.demibold(ofSize: 18)], range: NSMakeRange(0, 1))
        amountPerPersonLabel.attributedText = text
        
        totalBillView.configure(amount: result.totalBill)
        totalTipView.configure(amount: result.totalTip)
    }
}

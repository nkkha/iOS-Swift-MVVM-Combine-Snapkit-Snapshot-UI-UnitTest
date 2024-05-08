//
//  HeaderView.swift
//  Tip Calculator
//
//  Created by nkkha on 8/5/24.
//

import UIKit

class HeaderView: UIView {
    private let topLabel: UILabel = {
        LabelFactory.build(text: "", font: ThemeFont.bold(ofSize: 18), textAlignment: .left)
    }()
    
    private let bottomLabel: UILabel = {
        LabelFactory.build(text: "", font: ThemeFont.regular(ofSize: 18), textAlignment: .left)
    }()
    
    private lazy var vStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            topLabel,
            bottomLabel
        ])
        view.axis = .vertical
        view.spacing = -4
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
        addSubview(vStackView)
        
        vStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configure(topLabel: String, bottomLabel: String) {
        self.topLabel.text = topLabel
        self.bottomLabel.text = bottomLabel
    }
}

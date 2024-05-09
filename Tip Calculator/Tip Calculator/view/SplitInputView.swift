//
//  SplitInputView.swift
//  Tip Calculator
//
//  Created by nkkha on 7/5/24.
//

import UIKit
import Combine
import CombineCocoa

class SplitInputView: UIView {
    private let headerView: HeaderView = {
        let view = HeaderView()
        view.configure(topLabel: "Split", bottomLabel: "the total")
        return view
    }()
    
    private lazy var decrementButton: UIButton = {
        let button = buildButton(title: "-", corners: [.layerMinXMinYCorner, .layerMinXMaxYCorner])
        button.tapPublisher.sink { [unowned self] _ in
            splitSubject.send(splitSubject.value == 1 ? 1 : splitSubject.value - 1)
        }.store(in: &cancellables)
        return button
    }()
    
    private lazy var increaseButton: UIButton = {
        let button = buildButton(title: "+", corners: [.layerMaxXMinYCorner, .layerMaxXMaxYCorner])
        button.tapPublisher.sink { [unowned self] _ in
            splitSubject.send(splitSubject.value + 1)
        }.store(in: &cancellables)
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
    
    private let splitSubject = CurrentValueSubject<Int, Never>(1)
    var valuePublisher: AnyPublisher<Int, Never> {
        return splitSubject.removeDuplicates().eraseToAnyPublisher()
    }
    private var cancellables = Set<AnyCancellable>()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        layout()
        observe()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func observe() {
        splitSubject.sink { [unowned self] value in
            quantityLabel.text = String(value)
        }.store(in: &cancellables)
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
    
    private func buildButton(title: String, corners: CACornerMask) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.backgroundColor = ThemeColor.primary
        button.tintColor = .white
        button.titleLabel?.font = ThemeFont.bold(ofSize: 20)
        button.addRoundedCorners(corners: corners, radius: 8)
        return button
    }
    
    func reset() {
        splitSubject.send(1)
    }
}

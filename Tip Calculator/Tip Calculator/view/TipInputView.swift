//
//  TipInputView.swift
//  Tip Calculator
//
//  Created by nkkha on 7/5/24.
//

import UIKit
import Combine
import CombineCocoa

class TipInputView: UIView {
    private let headerView: HeaderView = {
        let view = HeaderView()
        view.configure(topLabel: "Choose", bottomLabel: "your tip")
        return view
    }()
    
    private lazy var tenPercentButton: UIButton = {
        let button = buildTipButton(tip: .tenPercent)
        button.tapPublisher.flatMap { _ in
            Just(Tip.tenPercent)
        }.assign(to: \.value, on: tipSubject)
            .store(in: &cancellables)
        return button
    }()
    
    private lazy var fifteenPercentButton: UIButton = {
        let button = buildTipButton(tip: .fifteenPercent)
        button.tapPublisher.flatMap { _ in
            Just(Tip.fifteenPercent)
        }.assign(to: \.value, on: tipSubject)
            .store(in: &cancellables)
        return button
    }()
    
    private lazy var twentyPercentButton: UIButton = {
        let button = buildTipButton(tip: .twentyPercent)
        button.tapPublisher.flatMap { _ in
            Just(Tip.twentyPercent)
        }.assign(to: \.value, on: tipSubject)
            .store(in: &cancellables)
        return button
    }()
    
    private lazy var customButton: UIButton = {
        let button = UIButton()
        button.setAttributedTitle(.init(string: "Custom Tip", attributes: [.font: ThemeFont.bold(ofSize: 20), .foregroundColor: UIColor.white]), for: .normal)
        button.backgroundColor = ThemeColor.primary
        button.tintColor = .white
        button.titleLabel?.font = ThemeFont.bold(ofSize: 20)
        button.addCornerRadius(radius: 8)
        button.tapPublisher.sink { [weak self] _ in
            self?.handleCustomTipButton()
        }.store(in: &cancellables)
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
    
    private let tipSubject = CurrentValueSubject<Tip, Never>(.none)
    var valuePublisher: AnyPublisher<Tip, Never> {
        return tipSubject.removeDuplicates(by: { $0.stringValue == $1.stringValue }).eraseToAnyPublisher()
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
        tipSubject.sink { [unowned self] tip in
            resetView()
            switch tip {
            case .none:
                break
            case .tenPercent:
                tenPercentButton.backgroundColor = ThemeColor.secondary
            case .fifteenPercent:
                fifteenPercentButton.backgroundColor = ThemeColor.secondary
            case .twentyPercent:
                twentyPercentButton.backgroundColor = ThemeColor.secondary
            case .custom(let value):
                let text = NSMutableAttributedString(string: "$\(value)", attributes: [.font: ThemeFont.bold(ofSize: 20), .foregroundColor: UIColor.white])
                text.addAttributes([.font: ThemeFont.demibold(ofSize: 14)], range: NSMakeRange(0, 1))
                customButton.setAttributedTitle(text, for: .normal)
                customButton.backgroundColor = ThemeColor.secondary
            }
        }.store(in: &cancellables)
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
    
    private func resetView() {
        [tenPercentButton, fifteenPercentButton, twentyPercentButton].forEach { $0.backgroundColor = ThemeColor.primary }
        
        customButton.backgroundColor = ThemeColor.primary
        customButton.setAttributedTitle(.init(string: "Custom Tip", attributes: [.font: ThemeFont.bold(ofSize: 20), .foregroundColor: UIColor.white]), for: .normal)
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
    
    private func handleCustomTipButton() {
        let alertController: UIAlertController = {
            let controller = UIAlertController(title: "Enter custom tip", message: nil, preferredStyle: .alert)
            controller.addTextField { textField in
                textField.placeholder = "Make it generous!"
                textField.keyboardType = .numberPad
                textField.autocorrectionType = .no
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
                guard let text = controller.textFields?.first?.text,
                      let value = Int(text) else { return }
                self?.tipSubject.send(Tip.custom(value: value))
            }
            controller.addAction(cancelAction)
            controller.addAction(okAction)
            return controller
        }()
        parentViewController?.present(alertController, animated: true)
    }
    
    func reset() {
        tipSubject.send(Tip.none)
    }
}

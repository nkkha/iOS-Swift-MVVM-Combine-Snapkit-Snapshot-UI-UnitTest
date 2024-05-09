//
//  CalculatorVM.swift
//  Tip Calculator
//
//  Created by nkkha on 9/5/24.
//

import Foundation
import Combine

class CalculatorVM {
    
    struct Input {
        let billPublisher: AnyPublisher<Double, Never>
        let tipPublisher: AnyPublisher<Tip, Never>
        let splitPublisher: AnyPublisher<Int, Never>
        let logoViewTapPublisher: AnyPublisher<Void, Never>
    }
    
    struct Output {
        let updateViewPublisher: AnyPublisher<Result, Never>
        let resetCalculatorPublisher: AnyPublisher<Void, Never>
    }
    
    private let audioPlayerService: AudioPlayerService
    
    init(audioPlayerService: AudioPlayerService = DefaultAudioPlayer()) {
        self.audioPlayerService = audioPlayerService
    }
        
    func transform(input: Input) -> Output {
        let updateViewPublisher = Publishers.CombineLatest3(
            input.billPublisher,
            input.tipPublisher,
            input.splitPublisher).flatMap { [unowned self] (bill, tip, split) in
                let tipAmount = getTipAmount(bill: bill, tip: tip)
                let totalBill = bill + tipAmount
                let amountPerPerson = totalBill / Double(split)
                let result = Result(amountPerPerson: amountPerPerson, totalBill: totalBill, totalTip: tipAmount)
                return Just(result)
            }.eraseToAnyPublisher()
        
        let resetPublisher = input.logoViewTapPublisher.handleEvents(receiveOutput: { [unowned self] _ in
            audioPlayerService.playSound()
        }).flatMap({
            Just($0)
        }).eraseToAnyPublisher()
        return Output(updateViewPublisher: updateViewPublisher, resetCalculatorPublisher: resetPublisher)
    }
    
    private func getTipAmount(bill: Double, tip: Tip) -> Double {
        switch tip {
        case .none:
            return 0
        case .tenPercent:
            return bill * 0.1
        case .fifteenPercent:
            return bill * 0.15
        case .twentyPercent:
            return bill * 0.2
        case .custom(let value):
            return Double(value)
        }
    }
}

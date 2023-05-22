//
//  ViewModel.swift
//  TwoZoneView
//
//  Created by Artem Bilyi on 19.05.2023.
//
import SwiftUI

protocol TwoZoneHandler {
    func onBlueZoneEvent(isPressed: Bool)
    func onYellowZoneEvent(idx: Int, x: Double, y: Double)
}

final class TwoZoneViewModel: ObservableObject {

    @Published var yellowShapePosition: CGPoint = .zero
    @Published var yellowShapeHeight: CGFloat = 0
    @Published var yellowShapeWidth: CGFloat = 0

    @Published var maxSize: CGSize = .zero {
        didSet {
            self.xPositionViewModel.set(maxValue: Int(maxSize.width))
            self.yPositionViewModel.set(maxValue: Int(maxSize.height))
            self.widthViewModel.set(maxValue: Int(maxSize.width))
            self.heightViewModel.set(maxValue: Int(maxSize.height))
        }

    }

    @Published var isYellowViewHidden = true
    @Published var isBlueViewHidden = true

    let xPositionViewModel: CustomConfigureViewModel
    let yPositionViewModel: CustomConfigureViewModel
    let widthViewModel: CustomConfigureViewModel
    let heightViewModel: CustomConfigureViewModel
    private let minimumSizeValue: Int = 0

    init() {
        xPositionViewModel = .init(title: "x position", minValue: minimumSizeValue)
        yPositionViewModel = .init(title: "y position", minValue: minimumSizeValue)
        widthViewModel = .init(title: "width", minValue: minimumSizeValue)
        heightViewModel = .init(title: "height", minValue: minimumSizeValue)
    }

    func configureViewTapped() {
        if xPositionViewModel.currentValue >= minimumSizeValue
            && xPositionViewModel.currentValue <= Int(maxSize.width) {
            self.yellowShapePosition.x = CGFloat(xPositionViewModel.currentValue)
        } else {
            self.xPositionViewModel.currentValue = minimumSizeValue
        }

        if yPositionViewModel.currentValue >= minimumSizeValue
            && yPositionViewModel.currentValue <= Int(maxSize.height) {
            self.yellowShapePosition.y = CGFloat(yPositionViewModel.currentValue)
        } else {
            self.yPositionViewModel.currentValue = minimumSizeValue
        }

        if widthViewModel.currentValue >= minimumSizeValue
            && widthViewModel.currentValue <= Int(maxSize.width) {
            self.yellowShapeWidth = CGFloat(widthViewModel.currentValue)
        } else {
            self.widthViewModel.currentValue = minimumSizeValue
        }

        if heightViewModel.currentValue >= minimumSizeValue
            && heightViewModel.currentValue <= Int(maxSize.width) {
            self.yellowShapeHeight = CGFloat(heightViewModel.currentValue)
        } else {
            self.heightViewModel.currentValue = minimumSizeValue
        }

        isYellowViewHidden = false
    }

}

// MARK: - TwoZoneHandler

extension TwoZoneViewModel: TwoZoneHandler {

    func onBlueZoneEvent(isPressed: Bool) {
        print("blue view state \(isPressed)")
    }
    
    func onYellowZoneEvent(idx: Int, x: Double, y: Double) {
        print("index: \(idx) x: \(x) y: \(y)")
    }

}

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

    @Published var showingAlert = false
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

    @Published private(set) var latestAlertTitle = ""
    @Published var isYellowViewHidden = true
    @Published var isBlueViewHidden = true

    var xPositionViewModel: CustomConfigureViewModel
    var yPositionViewModel: CustomConfigureViewModel
    var widthViewModel: CustomConfigureViewModel
    var heightViewModel: CustomConfigureViewModel
    private let minimumSizeValue: Int = 0

    init() {
        xPositionViewModel = .init(title: "x position", minValue: minimumSizeValue)
        yPositionViewModel = .init(title: "y position", minValue: minimumSizeValue)
        widthViewModel = .init(title: "width", minValue: minimumSizeValue + 1)
        heightViewModel = .init(title: "height", minValue: minimumSizeValue + 1)
    }

    func configureViewTapped() {
        if xPositionViewModel.currentValue >= minimumSizeValue
            && xPositionViewModel.currentValue <= Int(maxSize.width) {
            self.yellowShapePosition.x = CGFloat(xPositionViewModel.currentValue)
        } else {
            self.xPositionViewModel.currentValue = minimumSizeValue
            self.latestAlertTitle = "x position should be in range between 0 and \(Int(maxSize.width))"
            showingAlert = true
        }

        if yPositionViewModel.currentValue >= minimumSizeValue
            && yPositionViewModel.currentValue <= Int(maxSize.height) {
            self.yellowShapePosition.y = CGFloat(yPositionViewModel.currentValue)
        } else {
            self.yPositionViewModel.currentValue = minimumSizeValue
            self.latestAlertTitle = "y position should be in range between 0 and \(Int(maxSize.height))"
            showingAlert = true
        }

        if widthViewModel.currentValue > minimumSizeValue
            && widthViewModel.currentValue <= Int(maxSize.width) - self.xPositionViewModel.currentValue {
            self.yellowShapeWidth = CGFloat(widthViewModel.currentValue)
        } else {
            self.widthViewModel.currentValue = self.minimumSizeValue + 1
            self.latestAlertTitle = "width should be in range between 1 and \(Int(maxSize.width) - self.xPositionViewModel.currentValue)"
            showingAlert = true
        }

        if heightViewModel.currentValue > minimumSizeValue
            && heightViewModel.currentValue <= Int(maxSize.height) - self.yPositionViewModel.currentValue {
            self.yellowShapeHeight = CGFloat(heightViewModel.currentValue)
        } else {
            self.heightViewModel.currentValue = minimumSizeValue + 1
            self.latestAlertTitle = "height should be in range between 1 and \(Int(maxSize.height) - self.yPositionViewModel.currentValue)"
            showingAlert = true
        }
        isYellowViewHidden = false
    }
}
// MARK: - TwoZoneHandler

extension TwoZoneViewModel: TwoZoneHandler {

    func onBlueZoneEvent(isPressed: Bool) {
        print("Blue view state \(isPressed)")
    }
    func onYellowZoneEvent(idx: Int, x: Double, y: Double) {
        print("Index: \(idx)\nx: \(x) in percentage of width\ny: \(y) in percentage of height")
    }
}

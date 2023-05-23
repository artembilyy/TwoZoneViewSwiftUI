//
//  TouchableView.swift
//  TwoZoneView
//
//  Created by Artem Bilyi on 21.05.2023.
//

import SwiftUI

final class TouchableView: UIView {
    
    private var activeTouches: [(touch: UITouch, index: Int)] = []

    private let activeTouchesQueue = DispatchQueue(label: "test", attributes: .concurrent)

    private let viewModel = TwoZoneViewModel()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)

        for touch in touches {
            let touchPoint = touch.location(in: self)
            var blankIndex: Int? = nil

            activeTouchesQueue.sync(flags: .barrier) {
                for index in 0..<activeTouches.count {
                    if activeTouches.contains(where: { $0.index == index }) == false {
                        blankIndex = index
                        break
                    }
                }

                let newIndex: Int
                if let blankIndex = blankIndex {
                    newIndex = blankIndex
                } else {
                    newIndex = activeTouches.count
                }
                activeTouches.append((touch: touch, index: newIndex))
                if let superview = superview?.superview {
                    let (widthPercentage, heightPercentage) = calculatePointPercentage(frame: superview.frame, touchPoint: touchPoint)
                    viewModel.onYellowZoneEvent(
                        idx: newIndex,
                        x: widthPercentage,
                        y: heightPercentage
                    )
                    print(activeTouches.map { $0.index })
                }
            }

        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)

        activeTouchesQueue.sync(flags: .barrier) {
            activeTouches.removeAll { activeTouch in
                touches.contains(activeTouch.touch)
            }
            print(activeTouches.map { $0.index })
        }
    }
    func calculatePointPercentage(frame: CGRect, touchPoint: CGPoint) -> (Double, Double) {
        let maxWidth = frame.width
        let maxHeight = frame.height
        let percentageWidth = touchPoint.x / (maxWidth / 100)
        let roundedPercentageWidth = Double(String(format: "%.1f", percentageWidth)) ?? 0.0
        let percentageHeight = (touchPoint.y / maxHeight) * 100.0
        let roundedPercentageHeight = Double(String(format: "%.1f", percentageHeight)) ?? 0.0
        return (roundedPercentageWidth, roundedPercentageHeight)
    }
}
// MARK: - UIViewRepresentable
struct UIKitYellowView: UIViewRepresentable {

    func makeUIView(context: Context) -> TouchableView {
        let touchableView = TouchableView()
        touchableView.backgroundColor = .yellow
        touchableView.isMultipleTouchEnabled = true
        return touchableView
    }
    
    func updateUIView(_ uiView: TouchableView, context: Context) {
        // Update the view if needed
    }
}

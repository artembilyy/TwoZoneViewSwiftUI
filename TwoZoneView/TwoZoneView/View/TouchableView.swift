//
//  TouchableView.swift
//  TwoZoneView
//
//  Created by Artem Bilyi on 21.05.2023.
//

import SwiftUI

final class TouchableView: UIView {
    
    private var activeTouches: [(touch: UITouch, index: Int)] = []

    private let viewModel = TwoZoneViewModel()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)

        for touch in touches {
            let touchPoint = touch.location(in: self)
            var blankIndex: Int? = nil

            for index in 0..<activeTouches.count {
                if activeTouches.contains(where: { $0.index == index }) == false {
                    blankIndex = index
                } else {
                    continue
                }
            }

            let newIndex: Int
            if let blankIndex = blankIndex {
                newIndex = blankIndex
            } else {
                newIndex = activeTouches.count
            }

            activeTouches.append((touch: touch, index: newIndex))
            viewModel.onYellowZoneEvent(
                idx: newIndex,
                x: touchPoint.x,
                y: touchPoint.y
            )
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)

        for touch in touches {
            activeTouches.removeAll { activeTouch in
                activeTouch.touch == touch
            }
        }
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

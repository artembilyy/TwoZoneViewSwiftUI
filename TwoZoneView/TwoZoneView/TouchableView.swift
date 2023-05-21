//
//  TouchableView.swift
//  TwoZoneView
//
//  Created by Artem Bilyi on 21.05.2023.
//

//import UIKit
import SwiftUI

class TouchableView: UIView {
    
    var activeTouches: [UITouch] = []
    var touchIndexes: [Int] = []
    var vm = TwoZoneViewModel()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        for touch in touches {
            let touchPoint = touch.location(in: self)
            activeTouches.append(touch)
            if let index = activeTouches.firstIndex(of: touch) {
                touchIndexes.append(index)
                vm.onYellowZoneEvent(idx: touchIndexes, x: touchPoint.x, y: touchPoint.y)
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        for touch in touches {
            let touchPoint = touch.location(in: self)
            if let index = activeTouches.firstIndex(of: touch) {
                activeTouches.remove(at: index)
                if let touchIndex = touchIndexes.firstIndex(of: index) {
                    touchIndexes.remove(at: touchIndex)
                }
                vm.onYellowZoneEvent(idx: touchIndexes, x: touchPoint.x, y: touchPoint.y)
            }
        }
    }
    
}


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

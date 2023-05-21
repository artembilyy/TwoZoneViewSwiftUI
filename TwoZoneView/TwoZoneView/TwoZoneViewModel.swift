//
//  ViewModel.swift
//  TwoZoneView
//
//  Created by Artem Bilyi on 19.05.2023.
//

import Foundation

protocol TwoZoneViewModelProtocol: ObservableObject {
    var height: String { get }
    var widht: String { get }
    var xPosition: String { get }
    var yPosition: String { get }
    var widthValue: String { get }
    var heightValue: String { get }
}

protocol TwoZoneHandler {
    func onBlueZoneEvent(isPressed: Bool)
    func onYellowZoneEvent(idx: [Int], x: Double, y: Double)
}


final class TwoZoneViewModel: TwoZoneViewModelProtocol, TwoZoneHandler {
    
    @Published var height: String = ""
    @Published var widht: String = ""
    @Published var xPosition: String = ""
    @Published var yPosition: String = ""
    @Published var widthValue = ""
    @Published var heightValue = ""
    
    var newPositionX: Double = 0
    var newPositionY: Double = 0
    var newHeight: Double = 0
    var newWidth: Double = 0
    
    func makeSize() {
        newPositionX = Double(xPosition) ?? 0
        newPositionY = Double(yPosition) ?? 0
        newWidth = Double(widthValue) ?? 0
        newHeight = Double(heightValue) ?? 0
    }
    
    func onBlueZoneEvent(isPressed: Bool) {
        print("blue view state \(isPressed)")
    }
    
    func onYellowZoneEvent(idx: [Int], x: Double, y: Double) {
        print("indexes : \(idx.count) x: \(x) y: \(y)")
    }
}

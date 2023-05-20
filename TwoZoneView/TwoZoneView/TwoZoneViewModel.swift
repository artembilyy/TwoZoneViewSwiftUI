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

final class TwoZoneViewModel: TwoZoneViewModelProtocol {
    @Published var height: String = ""
    @Published var widht: String = ""
    @Published var xPosition: String = ""
    @Published var yPosition: String = ""
    @Published var widthValue = ""
    @Published var heightValue = ""
}

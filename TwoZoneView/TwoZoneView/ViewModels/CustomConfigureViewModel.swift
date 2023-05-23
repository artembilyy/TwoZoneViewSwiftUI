//
//  CustomConfigureViewModel.swift
//  TwoZoneView
//
//  Created by Artem Bilyi on 22.05.2023.
//

import SwiftUI

final class CustomConfigureViewModel: ObservableObject {

    let title: String
    let minValue: Int

    @Published var currentValue: Int = 0 {
        didSet {
            print(currentValue)
        }
    }
    
    @Published private(set) var maxValueDescription: String = ""
    @Published var maxSize: CGSize = CGSize.zero

    init(title: String, minValue: Int = 0) {
        self.title = title
        self.minValue = minValue
        self.currentValue = minValue
    }

    func set(maxValue: Int) {
        self.maxValueDescription = "\(title): from \(minValue) to \(maxValue)"
    }
}

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

    @Published var currentValue: Int = 0
    
    @Published var maxValueDescription: String = ""
    @Published var maxSize: CGSize = CGSize.zero

    private var maxValue: Int?
    
    init(title: String, minValue: Int = 0, maxValue: Int? = nil) {
        self.title = title
        self.minValue = minValue
        self.maxValue = maxValue
    }

    func set(maxValue: Int) {
        self.maxValue = maxValue
        self.maxValueDescription = "\(title): from \(minValue) to \(maxValue)"
    }

}

//
//  CustomTextField.swift
//  TwoZoneView
//
//  Created by Artem Bilyi on 19.05.2023.
//

import SwiftUI

struct CustomConfigureView: View {

    @ObservedObject var viewModel: CustomConfigureViewModel

    var body: some View {
        HStack {
            TextField(
                viewModel.title,
                value: $viewModel.currentValue,
                formatter: NumberFormatter()
            )
            .textFieldStyle(.roundedBorder)
            .keyboardType(.numberPad)
            .frame(width: 100)
            Spacer()
            Text(viewModel.maxValueDescription)
        }
    }
}

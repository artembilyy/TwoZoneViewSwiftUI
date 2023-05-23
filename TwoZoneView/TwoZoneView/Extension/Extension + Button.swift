//
//  Extension + Button.swift
//  TwoZoneView
//
//  Created by Artem Bilyi on 23.05.2023.
//

import SwiftUI

struct StaticButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
}

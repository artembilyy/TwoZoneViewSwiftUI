//
//  CustomTextField.swift
//  TwoZoneView
//
//  Created by Artem Bilyi on 19.05.2023.
//

import SwiftUI
import Combine

struct CustomConfigureView: View {
    
    enum ConfigureTextField: String {
        case xPosition = "x"
        case yPosition = "y"
        case width = "width"
        case height = "height"
    }
    
    let type: ConfigureTextField
    let binding: Binding<String>
    var value: String
    var numberValue: Int {
        Int(value) ?? 0
    }
    
    @State private var showAlert = false
    
    var body: some View {
        HStack {
            switch type {
            case .xPosition:
                makeTextField(title: type.rawValue, text: binding, value: value)
                Spacer()
                Text("X Position from 0 to \(value)")
                    .multilineTextAlignment(.trailing)
            case .yPosition:
                makeTextField(title: type.rawValue, text: binding, value: value)
                Spacer()
                Text("Y Position from 0 to \(value)")
                    .multilineTextAlignment(.trailing)
            case .width:
                makeTextField(title: type.rawValue, text: binding, value: value)
                Spacer()
                Text("Width from 0 to \(value)")
                    .multilineTextAlignment(.trailing)
            case .height:
                makeTextField(title: type.rawValue, text: binding, value: value)
                Spacer()
                Text("Height from 0 to \(value)")
                    .multilineTextAlignment(.trailing)
            }
        }
        .padding()
    }
    
    
    private func makeTextField(title: String, text observer: Binding<String>, value: String) -> some View {
        TextField(title, text: observer, onCommit: {
            if let number = Int(observer.wrappedValue),
                number < 0 ||
                number > Int(value) ?? 0 {
                showAlert = true
                print("\(number) number")
                print("\(numberValue) value")
            }
        })
        .textFieldStyle(.roundedBorder)
        .keyboardType(.numberPad)
        .frame(width: 100)
        .padding()
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Something went wrong"),
                message: Text("Value must be more than or equal 0 OR less or equal \(value)."),
                dismissButton: .default(Text("OK"))
            )
        }
    }
    private func isValidValue(_ input: String, value: String) -> Bool {
        if let inputValue = Int(input), let rangeValue = Int(value) {
            return inputValue >= 0 && inputValue <= rangeValue
        }
        return false
    }
}

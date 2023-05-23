//
//  ContentView.swift
//  TwoZoneView
//
//  Created by Artem Bilyi on 18.05.2023.
//

import SwiftUI

struct TwoZoneView: View {
    
    // MARK: Properties
    
    @ObservedObject private var viewModel = TwoZoneViewModel()
    /// hide keyboard
    @FocusState private var nameIsFocused: Bool
    // show // hide Blue bottom view
    @State private var configureView: Bool = false
    @State var isPressed = false

    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                VStack(spacing: 16) {
                    CustomConfigureView(viewModel: viewModel.xPositionViewModel)
                        .focused($nameIsFocused)
                    
                    CustomConfigureView(viewModel: viewModel.yPositionViewModel)
                        .focused($nameIsFocused)
                    
                    CustomConfigureView(viewModel: viewModel.widthViewModel)
                        .focused($nameIsFocused)
                    
                    CustomConfigureView(viewModel: viewModel.heightViewModel)
                        .focused($nameIsFocused)
                }.padding(.horizontal)
                
                // MARK: Buttons
                
                HStack {
                    Button {
                        viewModel.configureViewTapped()
                        nameIsFocused = false
                    } label: {
                        Text("Configure View")
                            .foregroundColor(.white)
                            .padding()
                            .background(.black)
                            .cornerRadius(16)
                    }
                    Spacer()
                    Button {
                        viewModel.isBlueViewHidden.toggle()
                        nameIsFocused = false
                    } label: {
                        Text(viewModel.isBlueViewHidden ? "Show Blue View" : "Hide Blue View")
                            .foregroundColor(.white)
                            .padding()
                            .background(.black)
                            .cornerRadius(16)
                    }
                }
                .padding(.horizontal)
                // MARK: Drawing view
                ZStack() {
                    VStack(spacing: 0) {
                        if viewModel.isYellowViewHidden == false {
                            UIKitYellowView()
                            if viewModel.isBlueViewHidden == false {
                                Divider()
                                    .frame(maxWidth: .infinity, maxHeight: 2)
                                    .background(.black)
                                Button(action: { }) {
                                    Rectangle()
                                        .foregroundColor(.blue)
                                        .frame(height: CGFloat(viewModel.yellowShapeHeight) * 0.3)
                                }
                                .buttonStyle(StaticButtonStyle())
                                ._onButtonGesture(pressing: { pressed in
                                    viewModel.onBlueZoneEvent(isPressed: pressed)
                                }, perform: { })
                            }
                        } else {
                            EmptyView()
                        }
                    }
                    .cornerRadius(16)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(.black, lineWidth: 2)
                    )
                    .frame(height: viewModel.yellowShapeHeight)
                    .frame(width: viewModel.yellowShapeWidth)
                    .position(x: viewModel.yellowShapeWidth / 2.0 + viewModel.yellowShapePosition.x,
                              y: viewModel.yellowShapeHeight / 2.0 + viewModel.yellowShapePosition.y)
                }
                .border(.black, width: 1)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .saveSize(in: $viewModel.maxSize)
                .padding(.horizontal)
            }
            .navigationBarTitle("Two Zone View", displayMode: .large)
        }.alert(isPresented: $viewModel.showingAlert) {
            Alert(title: Text(viewModel.latestAlertTitle))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TwoZoneView()
    }
}

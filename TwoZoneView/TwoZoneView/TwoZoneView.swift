//
//  ContentView.swift
//  TwoZoneView
//
//  Created by Artem Bilyi on 18.05.2023.
//

import SwiftUI

struct TwoZoneView: View {
    // MARK: - ViewModel
    @ObservedObject var viewModel = TwoZoneViewModel()
    /// hide keyboard
    @FocusState private var nameIsFocused: Bool
    // show // hide Blue bottom view
    @State private var isBlueViewHidden = false
    @State private var configureView: Bool = false
    @State var reload: Bool = false
    
    @GestureState var isGestureActive = false
    @State var touchDown = false
    @GestureState private var isTapped = false
    
    
    var body: some View {
        NavigationView {
            VStack(spacing: -30) {
                VStack(spacing: -50) {
                    CustomConfigureView(
                        type: .xPosition,
                        binding: $viewModel.xPosition,
                        value: viewModel.widht
                    )
                    .focused($nameIsFocused)
                    CustomConfigureView(
                        type: .yPosition,
                        binding: $viewModel.yPosition,
                        value: viewModel.height
                    )
                    .focused($nameIsFocused)
                    CustomConfigureView(
                        type: .width,
                        binding: $viewModel.widthValue,
                        value: String((Int(viewModel.widht) ?? 0) - (Int(viewModel.xPosition) ?? 0))
                    )
                    .focused($nameIsFocused)
                    CustomConfigureView(
                        type: .height,
                        binding: $viewModel.heightValue,
                        value: String((Int(viewModel.height) ?? 0) - (Int(viewModel.yPosition) ?? 0))
                    )
                    .focused($nameIsFocused)
                }
                VStack {
                    HStack {
                        Button {
                            viewModel.makeSize()
                            nameIsFocused = false
                        } label: {
                            Text("Configure View")
                                .foregroundColor(.white)
                                .padding()
                                .background(.black)
                                .cornerRadius(10)
                        }
                        Spacer()
                        Button {
                            isBlueViewHidden.toggle()
                            nameIsFocused = false
                        } label: {
                            Text(isBlueViewHidden ? "Show Blue View" : "Hide Blue View")
                                .foregroundColor(.white)
                                .padding()
                                .background(.black)
                                .cornerRadius(10)
                        }
                    }
                    .padding()
                    GeometryReader { geometry in
                        VStack(spacing: 0) {
                            makeMainView(
                                x: CGFloat(Double(viewModel.newPositionX)),
                                y: CGFloat(Double(viewModel.newPositionY)),
                                width: CGFloat(viewModel.newWidth),
                                height: CGFloat((viewModel.newHeight))
                            )
                        }
                        //                        }
                        .onAppear {
                            viewModel.height = String(Int(geometry.size.height))
                            viewModel.widht = String(Int(geometry.size.width))
                        }
                    }
                    .padding()
                }
            }
            .navigationBarTitle("Two Zone View", displayMode: .large)
        }
    }
}


private extension TwoZoneView {
    
    func makeMainView(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) -> some View {
        ZStack {
            VStack(spacing: 0) {
                UIKitYellowView()
                    .frame(height: isBlueViewHidden ? height : height * 0.7)
                
                if !isBlueViewHidden {
                    Rectangle()
                        .foregroundColor(.blue)
                        .transition(.opacity)
                        .frame(height: height * 0.3)
                        .gesture(DragGesture(minimumDistance: 0.0, coordinateSpace: .global)
                            .onChanged { _ in
                                if !touchDown {
                                    viewModel.onBlueZoneEvent(isPressed: true)
                                    touchDown = true
                                }
                            }
                            .onEnded { _ in
                                viewModel.onBlueZoneEvent(isPressed: false)
                                touchDown = false
                            }
                        )
                }
            }
        }
        .cornerRadius(15, corners: .allCorners)
        .frame(width: width, height: height)
        .position(x: width / 2 + x, y: height / 2 + y)
        .animation(.easeInOut, value: 0)
        .border(.black, width: 2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TwoZoneView()
    }
}

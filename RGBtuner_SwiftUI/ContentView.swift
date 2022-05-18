//
//  ContentView.swift
//  RGBtuner_SwiftUI
//
//  Created by Paul Matar on 16/05/2022.
//

import SwiftUI

extension ContentView {
    enum FieldType: Int {
        case red, green, blue
    }
}

struct ContentView: View {
    @State private var redValue = Double.random(in: 0...255)
    @State private var greenValue = Double.random(in: 0...255)
    @State private var blueValue = Double.random(in: 0...255)
    
    @FocusState private var focusedField: FieldType?
    
    var body: some View {
        ZStack {
            Color(.systemMint)
                .ignoresSafeArea()
            VStack(spacing: 20) {
                ColorView(redValue: redValue,
                          greenValue: greenValue,
                          blueValue: blueValue)
                .padding(.bottom, 50)
                
                ColorTunerView(value: $redValue, color: .red)
                    .focused($focusedField, equals: .red)
                ColorTunerView(value: $greenValue, color: .green)
                    .focused($focusedField, equals: .green)
                ColorTunerView(value: $blueValue, color: .blue)
                    .focused($focusedField, equals: .blue)
                
                Spacer()
                
            }.padding()
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Button(action: moveUp) {
                            Image(systemName: "chevron.up")
                        }.disabled(focusedField == .red ? true : false)
                        
                        Button(action: moveDown) {
                            Image(systemName: "chevron.down")
                        }.disabled(focusedField == .blue ? true : false)
                        
                        Spacer()
                        
                        Button("Done") {
                            focusedField = nil
                        }
                    }
                }
        }
    }
    
    private func moveUp() {
        focusedField = focusedField.map {
            FieldType(rawValue: $0.rawValue - 1) ?? .red
        }
    }
    private func moveDown() {
        focusedField = focusedField.map {
            FieldType(rawValue: $0.rawValue + 1) ?? .blue
        }
    }
}

struct ColorView: View {
    let redValue: Double
    let greenValue: Double
    let blueValue: Double
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .foregroundColor(
                Color(red: redValue / 255,
                      green: greenValue / 255,
                      blue: blueValue / 255)
            )
            .frame(width: UIScreen.main.bounds.width - 32,
                   height: UIScreen.main.bounds.height * 0.15)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(.white, lineWidth: 4)
            )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portrait)
    }
}

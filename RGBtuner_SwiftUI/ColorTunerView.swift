//
//  ColorTunerView.swift
//  RGBtuner_SwiftUI
//
//  Created by Paul Matar on 17/05/2022.
//

import SwiftUI

struct ColorTunerView: View {
    @Binding var value: Double
    
    @State private var inputText = ""
    @State private var isPresented = false
    
    let color: Color
    
    var body: some View {
        HStack {
            Text("\(lround(value))")
                .frame(width: 33, alignment: .leading)
                .foregroundColor(.white)
            Slider(value: $value, in: 0...255)
                .tint(color)
                .onAppear { inputText = "\(lround(value))" }
                .onChange(of: value) { newValue in
                    inputText = "\(lround(newValue))"
                }
            TextField("255", text: $inputText) { _ in
                withAnimation {
                    isValid()
                }
            }
            .frame(width: 50, alignment: .trailing)
            .textFieldStyle(.roundedBorder)
            .keyboardType(.decimalPad)
            .alert("Value should be from 0 to 255!", isPresented: $isPresented) {}
        }
    }
    
    private func isValid() {
        guard let tempValue = Double(inputText), (0...255).contains(tempValue) else {
            isPresented.toggle()
            value = 0
            inputText = "0"
            return
        }
        value = tempValue
    }
    
}

struct ColorTunerView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.gray
            ColorTunerView(value: .constant(100), color: .blue)
        }
    }
}

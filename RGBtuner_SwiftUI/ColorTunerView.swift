//
//  ColorTunerView.swift
//  RGBtuner_SwiftUI
//
//  Created by Paul Matar on 17/05/2022.
//

import SwiftUI

struct ColorTunerView: View {
    @Binding var value: Double
    
    let color: Color
    
    let numberFormatter: NumberFormatter = {
        var nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.maximumFractionDigits = 0
        nf.maximum = 255
        nf.minimum = 0
    
        return nf
    }()
    
    var body: some View {
        HStack {
            Text(String(format: "%.f", value))
                .foregroundColor(.white)
                .frame(minWidth: 5, idealWidth: 15, maxWidth: 33, alignment: .leading)
            Slider(value: $value, in: 0...255)
                .tint(color)
                .padding(.trailing, 5)
            TextField("255", value: $value, formatter: numberFormatter)
                .keyboardType(.decimalPad)
                .textFieldStyle(.roundedBorder)
                .fixedSize()
        }
    }
}

struct ColorTunerView_Previews: PreviewProvider {
    static var previews: some View {
        ColorTunerView(value: .constant(100), color: .blue)
    }
}

//
//  SelectCurrency.swift
//  LOTR
//
//  Created by ceboi on 15/01/25.
//

import SwiftUI

struct SelectCurrency: View {
    
    @Environment(\.dismiss) var dismissSelectCurrency
    @Binding var topCurrency: Currency
    @Binding var bottomCurrency: Currency
    var body: some View {
        ZStack {
            // background
            Image(.parchment)
                .resizable()
                .ignoresSafeArea()
                .background(.brown)
            VStack {
                // text
                Text("Select the currency you are starting with:")
                    .fontWeight(.bold)
                
                // currency icons
                IconGrid(selectedCurrency: $topCurrency)
                // text
                Text("Select the currency your would like to convert to:")
                    .fontWeight(.bold)
                    .padding(.top)
                
                // currency icons
                IconGrid(selectedCurrency: $bottomCurrency)
                // button
                Button("Done") {
                    dismissSelectCurrency()
                }
                .buttonStyle(.borderedProminent)
                .tint(.brown.mix(with: .black, by: 0.2))
                .font(.largeTitle)
                .padding()
                .foregroundStyle(.white)
            }
            .padding()
            .multilineTextAlignment(.center)
            .foregroundStyle(.black)
        }
    }
}

#Preview {
    @Previewable @State var topCurrency: Currency = .silverPenny
    @Previewable @State var bottomCurrency: Currency = .copperPenny
    SelectCurrency(topCurrency: $topCurrency, bottomCurrency: $bottomCurrency)
}

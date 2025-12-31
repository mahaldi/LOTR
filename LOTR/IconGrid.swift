//
//  IconGrid.swift
//  LOTR
//
//  Created by ceboi on 29/12/25.
//

import SwiftUI

struct IconGrid: View {
    
    @Binding var selectedCurrency: Currency
    var body: some View {
        LazyVGrid(columns: [GridItem(), GridItem(), GridItem()]) {
            ForEach(Currency.allCases, id: \.self) { item in
                if selectedCurrency == item {
                    CurrencyIcon(currencyImage: item.image, currencyName: item.name)
                        .shadow(color: .black, radius: 10)
                        .overlay {
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(lineWidth: 3)
                                .opacity(0.5)
                        }
                } else {
                    CurrencyIcon(currencyImage: item.image, currencyName: item.name)
                        .onTapGesture {
                            selectedCurrency = item
                        }
                }
                
            }
            
        }
    }
}

#Preview {
    @Previewable @State var currency: Currency = .silverPiece;
    IconGrid(selectedCurrency: $currency)
}

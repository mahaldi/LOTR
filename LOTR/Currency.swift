//
//  Currency.swift
//  LOTR
//
//  Created by ceboi on 23/12/25.
//
import SwiftUI

enum Currency: Double, CaseIterable, Identifiable { // Identifiable untuk nambahin id
    case copperPenny = 6400
    case silverPenny = 64
    case silverPiece = 16
    case goldPenny = 4
    case goldPiece = 1
    
    var id: Currency { self } // ga perlu ini juga bisa asal pas di loop, dikasih id: \.self
     
    var image: ImageResource {
        switch self {
        case .copperPenny: // refer ke variable case diatas
                .copperpenny // refer ke nama file image yang ada di Assets
        case .silverPenny:
                .silverpenny
        case .silverPiece:
                .silverpiece
        case .goldPenny:
                .goldpenny
        case .goldPiece:
                .goldpiece
        }
    }
    
    var name: String {
        switch self {
        case .copperPenny:
            "Copper Penny"
        case .silverPenny:
            "Silver Penny"
        case .silverPiece:
            "Silver Piece"
        case .goldPenny:
            "Gold Penny"
        case .goldPiece:
            "Gold Piece"
        }
    }
     
    func convert(_ amount: String, to currency: Currency) -> String {
        guard let doubleAmount = Double(amount) else {
            return ""
        }
        
        let convertedAmount = (doubleAmount / self.rawValue) * currency.rawValue
        
        return String(format: "%.2f", convertedAmount)
    }
}

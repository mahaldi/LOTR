//
//  CurrencyTip.swift
//  LOTR
//
//  Created by ceboi on 31/12/25.
//

import TipKit

struct CurrencyTip: Tip {
    var title = Text("Change Currency")
    
    var message: Text? = Text("tap the left or right currency icon to change the currency")
    
    var image: Image? = Image(systemName: "hand.tap.fill")
}

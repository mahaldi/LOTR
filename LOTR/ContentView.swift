//
//  ContentView.swift
//  LOTR
//
//  Created by ceboi on 11/01/25.
//

import SwiftUI
import TipKit

struct ContentView: View {
    @State var showExchangeInfo = false
    @State var showSelectedCurrency = false
    @State var leftAmount = ""
    @State var rightAmount = ""
    
    @FocusState var isLeftTyping: Bool
    
    @State var leftCurrency = Currency.silverPiece
    @State var rightCurrency: Currency = .goldPiece
    
    let currencyTip = CurrencyTip()
    var body: some View {
        ZStack {
            // background
            Image(.background)
                .resizable()
                .ignoresSafeArea(.all)
            VStack {
                // logo
                Image(.prancingpony)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                // currency exchange text
                Text("Currency Exchange")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                // conversion section
                HStack {
                    // silver piece stack
                    VStack {
                        // currency image and text stack
                        HStack {
                            // currency image
                            Image(leftCurrency.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 33)
                            // text
                            Text(leftCurrency.name)
                                .font(.headline)
                                .foregroundStyle(.white)
                        }
                        .padding(.bottom, -5)
                        .onTapGesture {
                            showSelectedCurrency.toggle()
                            currencyTip.invalidate(reason: .actionPerformed)
                        }
                        .popoverTip(currencyTip,arrowEdge: .bottom)
                        // text field
                        TextField("Amount", text: $leftAmount)
                            .textFieldStyle(.roundedBorder)
                            .focused($isLeftTyping)
                            .onChange(of: leftAmount) {
                                if isLeftTyping {
                                    rightAmount = leftCurrency.convert(leftAmount, to: rightCurrency)
                                }
                            }
                    }
                    // equal symbol
                    Image(systemName: "equal")
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                        .symbolEffect(.pulse)
                    // gold piece stack
                    VStack {
                        // currency image and text stack
                        HStack {
                            // text
                            Text(rightCurrency.name)
                                .font(.headline)
                                .foregroundStyle(.white)
                            // currency image
                            Image(rightCurrency.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 33)
                        }
                        .padding(.bottom, -5)
                        .onTapGesture {
                            showSelectedCurrency.toggle()
                        }
                        // text field
                        TextField("Amount", text: $rightAmount)
                            .textFieldStyle(.roundedBorder)
                            .multilineTextAlignment(.trailing)
                            .onChange(of: rightAmount) {
                                if isLeftTyping == false {
                                    leftAmount = rightCurrency.convert(rightAmount, to: leftCurrency)
                                }
                            }
                    }
                }
                .padding()
                .background(.black.opacity(0.5))
                .clipShape(.capsule)
                .keyboardType(.decimalPad)
                
                Spacer()
                // info button
                HStack {
                    Spacer()
                    Button {
                        showExchangeInfo.toggle()
                    } label: {
                        Image(systemName: "info.circle.fill")
                            .font(.largeTitle)
                            .foregroundStyle(.white)
                    }
                    .padding(.trailing)
                    .task {
                        try? Tips.configure()
                    }
                    .onAppear {
                        let savedLeftCurrency = UserDefaults.standard.double(forKey: "leftCurrency")
                        let savedRightCurrency = UserDefaults.standard.double(forKey: "rightCurrency")
                        if let savedLeftCurrency = Currency(rawValue: savedLeftCurrency) {
                            self.leftCurrency = savedLeftCurrency
                        }
                        if let savedRightCurrency = Currency(rawValue: savedRightCurrency) {
                            self.rightCurrency = savedRightCurrency
                        }
                    }
                    .onChange(of: leftCurrency, {
                        leftAmount = rightCurrency.convert(rightAmount, to: leftCurrency)
                        UserDefaults.standard.set(leftCurrency.rawValue, forKey: "leftCurrency")
                    })
                    .onChange(of: rightCurrency, { oldValue, newValue in
                        rightAmount = leftCurrency.convert(leftAmount, to: rightCurrency)
                        UserDefaults.standard.set(rightCurrency.rawValue, forKey: "rightCurrency")
                    })
                    .sheet(isPresented: $showExchangeInfo) { // sheet ini ga harus di taroh di button bebas dimana aja, karna untuk nge buka sheet dia hanya perlu nge watch value dari variable $showExchangeInfo
                        ExchangeInfo()
                    }
                    .sheet(isPresented: $showSelectedCurrency) {
                        SelectCurrency(topCurrency: $leftCurrency, bottomCurrency: $rightCurrency)
                    }
                }
            }
        }
        .onTapGesture {
            // to hide keyboard
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
}

#Preview {
    ContentView()
}

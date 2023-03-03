//
//  TotalBarView.swift
//  billie
//
//  Created by Luciana Adrião on 27/09/22.
//

import SwiftUI

struct TotalOverlay: View {
    var sumTotalPrice: Double
    @Binding var slideSuceeded: Bool
    
    var body: some View {
        let itemModel = TabItem()
        
        VStack(alignment: .leading) {
            Group {
                HStack{
                    Text("Total")
                    Spacer()
                    Text(sumTotalPrice, format: .currency(code: itemModel.localeCode))
                }
                .accessibilityElement(children: .combine)
                .accessibilityLabel("Total" + String(sumTotalPrice))
                .font(.TotalOverlayFont)
                HStack{
                    Text("10% Tip")
                        .font(.body)
                    Spacer()
                    Text(sumTotalPrice*0.1, format: .currency(code: itemModel.localeCode))
                }
                .foregroundColor(.secondary)
                .accessibilityElement(children: .combine)
                .accessibilityLabel("10% de gorjeta," + String(sumTotalPrice*0.1))
            }
           
            SliderButton(success: $slideSuceeded)
                .scenePadding([.top])
        }
        .padding([.leading, .trailing, .top], 20)
    }
}

//struct TotalOverlay_Previews: PreviewProvider {
//    
//    static var previews: some View {
//        
//        TotalOverlay(sumTotalPrice: 20, slideSuceeded: .constant(false))
//    }
//}

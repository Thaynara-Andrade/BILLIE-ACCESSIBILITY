//
//  SwiftUIView.swift
//  billie
//
//  Created by Thaynara Andrade on 23/09/22.
//
//  File currently not in use

import SwiftUI

struct CheckoutView: View {
    var totalPrice: Double
    var tip: Double {
        get{
            return totalPrice*0.1
        }
    }
    
    var body: some View {
        VStack{
            Spacer(minLength: 20)
            Section(header: Text("Payment methods")
                .bold()
                .font(.title3)
            ){
                
                List{
                    Label ( "Pix", image: "IconPix")
                        .accessibilityLabel("Pagamento em PIX")
                    Label ( "Cash", image: "IconMoney")
                        .accessibilityLabel("Pagamento em Dinheiro")
                    Label ( "Apple pay", image: "IconApplePay")
                        .accessibilityLabel("Pagamento no Apple pay")
                    Label ( "Add payment method", systemImage: "plus")
                        .accessibilityLabel("Adicionar outro método de pagamento")
                }
                Spacer(minLength: 20)
                
            }
            HStack{
                Button {
                    // nada
                } label: {
                    Text("Pay now")
                        .padding()
                        .font(.title2)
                        .foregroundColor(.white)
                        .background(Color.green)
                        .cornerRadius(20)
                        .bold()
                        .buttonStyle(.plain)
                }
            }
        }.navigationTitle("")
    }
}
struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(totalPrice: 100)
    }
}

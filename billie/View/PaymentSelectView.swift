//
//  PaymentSelectView.swift
//  billie
//
//  Created by Thaynara da Silva Andrade on 17/02/23.
//
import SwiftUI
import Foundation

struct PaymentSelectView: View {
    
    @Environment(\.dismiss) private var dismiss
    var PaymentIndex = ["Dinheiro", "Pix",  "Apple pay"]
    @State var selectedIndex = 0
    @Environment(\.colorScheme) var colorScheme
    var totalPrice: Double
    @Binding var shouldPop: Bool
    
    var body: some View {
        let actionColor = Color.red
        let accentColor = Color.blue
        
        ZStack(alignment: .center) {
            VStack(alignment: .leading) {
                Group {
                    HStack{
                        
                        Text("Total:")
                        Spacer()
                        Text("R$ \(totalPrice + totalPrice*0.1, specifier: "%.2f")")
                    }
                    .font(Font.title3.bold())
                    HStack{
                        Text("Forma de pagamento:")
                        Spacer()
                        Text("\(PaymentIndex[selectedIndex])")
                    } 
                    
                        .foregroundColor(.secondary)
                    Button(action: {
                        shouldPop.toggle()
                        dismiss()
                    }){
                        Text("Confirmar")
                            .font(.title2.bold())
                                        .padding(.vertical, 12)
                                        .foregroundColor(Color.white)
                                        .frame(maxWidth: .infinity)
                                        .background (selectedIndex >  0  ?  Color (UIColor.gray ) :  Color (UIColor.systemCyan))
                                        .cornerRadius(5)
                    }
                }
                
            }.padding(.all, 20)

        }
    }
    
}


struct PaymentSelectView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentSelectView(totalPrice: 20, shouldPop: .constant(false))
    }
}

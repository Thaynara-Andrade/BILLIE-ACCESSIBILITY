//
//  PaymentSelectView.swift
//  billie
//
//  Created by Thaynara da Silva Andrade on 17/02/23.
//
import SwiftUI

struct PaymentSelectView: View {
    
    @Environment(\.dismiss) private var dismiss
    var PaymentIndex = ["Dinheiro", "Pix",  "Apple pay"]
    @State var selectedIndex = 0
    @Environment(\.colorScheme) var colorScheme
    var totalPrice: Double
    @Binding var shouldPop: Bool
    
    var body: some View {
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
                            .padding([.leading, .trailing], 108)
                            .padding(.all)
                            .foregroundColor(.white)
                            .shadow(radius: 90)
                            .font(.title2.bold())
                            .background(selectedIndex > 0 ? Color(UIColor.gray) : Color(UIColor.systemCyan))
                            .cornerRadius(5)
                    }
                }
                
            }.padding(.all, 20)
            
            Rectangle()
                .foregroundColor(colorScheme == .light ? Color(UIColor.white): Color(UIColor.systemGray6) )
                .zIndex(-1)
                //.ignoresSafeArea()
                .padding(.bottom)
                .cornerRadius(25)
                .shadow(radius: 10)
        } .frame(height: UIScreen.main.bounds.height/4)
        
    


        //            Rectangle()
        //                .foregroundColor(colorScheme == .light ? Color(UIColor.white): Color(UIColor.systemGray6) )
        //                .shadow(radius: 4)
        //                .zIndex(-1)
    }
    
}


struct PaymentSelectView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentSelectView(totalPrice: 20, shouldPop: .constant(false))
    }
}

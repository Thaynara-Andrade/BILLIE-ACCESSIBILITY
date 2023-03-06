import SwiftUI
import Foundation

struct PaymentView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) var colorScheme
    var PaymentIndex = ["Dinheiro", "Pix",  "Apple pay"]
    let alignment: Alignment = .bottom
    @Binding var shouldPop: Bool
    @State var selectedIndex = 0
    @State var alertButton = false
    @Binding var items: [TabItem]
    @State  var images: [Image] = [Image("IconMoney"), Image("IconPix"), Image("IconApplePay")]
    
    var sumOfAllItems: Double {
        let totalPrices = items.map(\.totalPrice)
        return totalPrices.reduce(0, +)
    }

    
    
    
    var body: some View {
        
        ZStack(alignment: .top) {
            NavigationStack{
                Form {
                    Section("Formas de pagamento") {
                        Picker(selection: $selectedIndex,label: EmptyView()){
                            ForEach(0 ..< PaymentIndex.count) {
                                if $0 < 1 {
                                    PickerRowView(image: images[$0], text: "\(PaymentIndex[$0])")
                                } else {
                                    PickerRowView(image: images[$0], text: "\(PaymentIndex[$0])").foregroundColor(.gray)
                                }
                            }
                        }
                        .accentColor(selectedIndex > 0 ? Color.clear : Color.actionColor)
                        
                    }.pickerStyle(.inline)
                        .onChange(of: selectedIndex, perform: { _ in
                            selectedIndex > 0 ? alertButton.toggle(): nil
                        })
                        .alert(isPresented: $alertButton) {
                            Alert(title: Text("Este método de pagamento ainda não está disponível"),
                                  message: Text("Desculpe! Nossa equipe está trabalhando para disponibilizar esse recurso o mais rápido possível."),
                                  dismissButton: .default(Text("Entendi")))
                        }
                    
                }
                .listStyle(.sidebar)
                
                PaymentSelectView(totalPrice: sumOfAllItems, shouldPop: $shouldPop)
                    .frame(maxHeight:155 , alignment: .bottom)
                    //.ignoresSafeArea()
                // .padding(.bottom)
                
                
                
            }
        } 
      }
    }
    
    struct TestePaymentView_Previews: PreviewProvider {
        @State static var items: [TabItem] = [
            TabItem(),
            TabItem()
        ]
        static var previews: some View {
            PaymentView(shouldPop: .constant(false), items: $items)
        }
    }


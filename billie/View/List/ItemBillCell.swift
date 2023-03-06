//
//  ItemBillCell.swift
//  billie
//
//  Created by Luciana Adrião on 27/09/22.


import SwiftUI

struct ItemBillCell: View {
    @Binding var itemModel: TabItem
    @FocusState private var field: Field?
    @State var isFocused: Bool = false
    
    
    var body: some View {
        HStack(alignment: .center) {
            VStack( alignment: .leading) {
//                if itemModel.isEditing {
//                    editItemView
//                } else {
//                    plainItemView
//                }
                HStack(alignment: .center) {
                    
                    if itemModel.isEditing {
                        editTextField
                    } else {
                        Text(itemModel.name)
                            .font(.nameCellFont)
//                            .lineLimit(1)
                    }
                    
                    if !itemModel.isEditing{
                        Spacer()
                        Text(itemModel.totalPrice, format: .currency(code: itemModel.localeCode))
                            .font(.body.bold())
                            .foregroundColor(itemModel.invalidDoubleValue(value: itemModel.totalPrice))
                            .accessibilityLabel("Valor total" + String(itemModel.totalPrice))
                    }
                }
                
                HStack(alignment: .bottom) {
                    
                    if itemModel.isEditing {
                        TextField("Please enter the price per unit", value: $itemModel.unitPrice, formatter: itemModel.formatter)
                            .textFieldStyle(.roundedBorder)
                            .foregroundColor(itemModel.invalidDoubleValue(value: itemModel.unitPrice))
                            .keyboardType(.decimalPad)
                            .focused($field, equals: .unitPrice)
    
                    }
                    if !itemModel.isEditing {
                        Text(itemModel.unitPrice, format: .currency(code: itemModel.localeCode))
                            .foregroundColor(itemModel.invalidDoubleValue(value: itemModel.unitPrice))
                            .accessibilityLabel("Valor unitário" + String(itemModel.unitPrice))
                        Spacer()
                        Button("") {
                            itemModel.quantity = itemModel.quantityControl(quantityValue: itemModel.quantity)
                        }.buttonStyle(quantityButton(nameString: "minus.circle"))
                            .accessibilityLabel("remover iténs")
                        
                        Text("\(itemModel.quantity)x")
                            .accessibilityLabel("Quantidade de iténs" + String(itemModel.quantity))
                        
                        Button("") {
                            itemModel.quantity = itemModel.quantity + 1
                        }.buttonStyle(quantityButton(nameString: "plus.circle"))
                            .accessibilityLabel("Adicionar iténs")
                       
                        
                    }
                }
            }.padding([.leading, .trailing], 10)
            
            if itemModel.isEditing {
                Button("") {
                    itemModel.isEditing.toggle()
                }.buttonStyle(doneEditingButton())
            }
        }
        .onTapGesture {
            if itemModel.isEditing == false{
                itemModel.isEditing.toggle()
            }

        }
    }
    
    var editTextField: some View {
        TextField("Edit name", text: $itemModel.name)
            .textFieldStyle(.roundedBorder)
            .font(.nameCellFont)
//            .lineLimit(1)
            .focused($field, equals: .name)
//            .accessibilityLabel("Digite o nome do itém")
    }
    
}


//struct ItemBillCell_Previews: PreviewProvider {
//    @State static var ab1 = TabItem(name: "ABOBRINHA", quantity: 10, unitPrice: 22.0 )
//    
//    static var previews: some View {
//        ItemBillCell(itemModel: $ab1)
//        
//    }
//}



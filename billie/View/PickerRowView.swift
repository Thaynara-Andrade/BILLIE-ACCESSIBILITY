import SwiftUI

struct PickerRowView: View {
    @State var image: Image
    @State var text: String
    // alterações aqui
    @ScaledMetric var scale: CGFloat = 1

    var body: some View {
        HStack{
            image
                .resizable()
                .frame(width: 16 * scale, height: 16 * scale)
            Spacer().frame(width: 16)
            Text(text)
        }
    }
}

struct PickerRowView_Previews: PreviewProvider {
    static var previews: some View {


        PickerRowView(image: Image(systemName: "checkbox"), text: "Teste")
    }
}

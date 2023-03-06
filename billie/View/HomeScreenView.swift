import SwiftUI

struct HomeScreenView: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var recognizedContent = RecognizedContent()
    @State var showScanner = false
    @State private var isRecognized: Bool = false
    @State var isEnded: Bool = false
    @State var items: [TabItem] = []
    @State var alertHelpButton = false
    @State var alertError = false
    
    var body: some View {
        NavigationStack {
            VStack (alignment: .center) {
                
                ZStack(){
                    LottieView(isEnded: $isEnded, filename: "BillieMoneySupposedlyFinal")
                        .shadow(color: .indigo, radius: 2, x: 1, y: 2)
                }
                .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.midY)
                .ignoresSafeArea(.all)
                
                
                Button("") {
                    showScanner = true
                    let impactGen = UIImpactFeedbackGenerator(style: .medium)
                    impactGen.impactOccurred()
                }.buttonStyle(scanButton(isEnded: isEnded))
                    .accessibilityLabel("Fazer o escaner da nota fiscal")
                
                Button("") {
                    isRecognized.toggle()
                }.buttonStyle(manualEnterButton(isEnded: isEnded))
                    .accessibilityLabel("Digitar manualmente os dados da nota fiscal")
                
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button() {
                        alertHelpButton = true
                    }label: {
                        Image(systemName: "questionmark.circle.fill")
                            .foregroundColor(Color.white)
                            .font(Font.body)
                            .padding(.all, 10)
                            .accessibilityLabel("Deseja saber como o App funciona?")
                    }.alert(isPresented: $alertHelpButton) {
                        Alert(title: Text("Hi, I'm Billie, your new bill-paying buddy."),
                              message: Text("""
                                            Here you can scan or manually add, your table's invoice;
                                            edit the scanned items or values, if necessary;
                                            add up your expenses and finally send the payment to the establishment.

                                            Simple, fast and secure.
                                            """),
                              dismissButton: .default(Text("Got it")))
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(colorScheme == .light ? LinearGradient.backgroundGradientLight:
                            LinearGradient.backgroundGradientDark)
            .navigationDestination(isPresented: $isRecognized) {
                CheckView(itemData: $items)
            }
            .alert(isPresented: $alertError){
                Alert(title: Text("Scan error"),
                      message: Text("There was an error scanning your receipt 😟 You can try again framing only its most important parts (the itens and the prices)"),
                      dismissButton: .default(Text("Try again")))
            }
        }
        .accentColor(.actionColor)
        .sheet(isPresented: $showScanner, content: {
            ScannerView { result in
                recognizedContent.items.removeAll()
                switch result {
                case .success(let scannedImages):
                    recognizedContent.items.removeAll()
                    TextRecognition(scannedImages: scannedImages,
                                    recognizedContent: recognizedContent) {
                        // Text recognition is finished, hide the progress indicator.
                        print("RESULT:")
                        print(recognizedContent.items[0].text)
                        print("REGEX:")
                        var res = RegexNF().RegexToItem(str: recognizedContent.items[0].text)
                        self.items.removeAll()
                        self.items.append(contentsOf: res)
                        print(items)
                        if !items.isEmpty {
                            isRecognized.toggle()
                            
                        }else{
                            alertError.toggle()
                        }
                    }.recognizeText()
                case .failure(let error):
                    print(error.localizedDescription)
                    alertError.toggle()
                }
                showScanner = false
            } didCancelScanning: {
                // Dismiss the scanner controller and the sheet.
                showScanner = false
                
                let cancelHap = UIImpactFeedbackGenerator(style: .rigid)
                cancelHap.impactOccurred()
            }
        })
    }
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        
        HomeScreenView()
    }
}

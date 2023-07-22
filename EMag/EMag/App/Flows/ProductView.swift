//Created by chizztectep on 15.07.2023 

import SwiftUI


struct ReviewData: Identifiable {
    let id = UUID()
    let idUser:Int
    let text: String
}



struct ProductData: Identifiable{
    let id = UUID()
    let productName: String
    let productPrice: Int
    let productDescription: String
}

/// A view that shows the data for one review.
struct ReviewRow: View {
    var review: ReviewData

    var body: some View {
        HStack {
            Text("\(review.idUser)")
            Text(review.text)
        }
    }
}

struct GrowingButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(.blue)
            .foregroundStyle(.white)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct ProductView: View {
    // MARK: Vars
    var productId: Int
    @State var productData: ProductData?
    @State var reviewsData: [ReviewData] = []
    @State var quantity: Int?
    @State var alertOnEmptyQuantity: Bool = false
    @State var alertOnAddBasketFailure: Bool = false
    @State var addBasketError: String = ""
    
    
    // MARK: body
    var body: some View {
        NavigationView{
            Form {
                Section {
                    VStack{
                        Text(productData?.productName ?? "")
                        let productPrice = productData?.productPrice ?? -1
                        Text("Цена: \(productPriceDescription(price:productPrice))")
                        Text("Описание: \(productData?.productDescription ?? "Без описания")")
                        HStack{
                            Button("В корзину") {
                                if quantity == nil || quantity == 0 {
                                    alertOnEmptyQuantity = true
                                } else {
                                    alertOnEmptyQuantity = false
                                    // TODO: вызов addBasket
                                    addBasket(productId: productId, quantity: quantity!)
                                    
                                }
                                
                            }.buttonStyle(GrowingButton())
                            .alert(isPresented:$alertOnEmptyQuantity) {
                                           Alert(
                                               title: Text("Не указано количество товара"),
                                               //message: Text("There is no undo"),
                                               dismissButton: .default(Text("ОК"))
                                           )
                                       }
                            TextField("Кол-во", value: $quantity, format: .number)
                                 .padding(20)
                                 .keyboardType(.decimalPad)
                         }

                    }
                }
                Section(header: Text("Отзывы")) {
                    List(reviewsData){ review in
                        ReviewRow(review: review)
                    }
                }.alert(isPresented: $alertOnAddBasketFailure) {
                    Alert(
                        title: Text("Ошибка при добавлении товара в корзину"),
                        message: Text("\(addBasketError)"),
                        dismissButton: .default(Text("ОК"))
                    )
                }
            }
          
        }.onAppear{
            requestProduct()
            requestReviews()
        }
            
    }
    
    // MARK: - Private Functions
    private func productPriceDescription(price: Int?) -> String {
        let productPrice = price ?? -1
        return  productPrice == -1 ?  "N/A" : "\(productPrice)"
    }
    
    private func addBasket(productId: Int, quantity: Int) {
        let basket = RequestFactory.shared.makeBasketRequestFactory()
        basket.addBasket(productId: productId, quantity: quantity) { response in
            switch response.result {
            case .success(let response) : print("Товар добавлен в корзину")
                                          alertOnAddBasketFailure = false
            case .failure(let error) :
                addBasketError = error.localizedDescription
                alertOnAddBasketFailure = true
            }
        }

    }
    
    private func requestProduct() {
        let catalog = RequestFactory.shared.makeCatalogRequestFactory()
        catalog.getProductById(idProduct: productId) { response in
            switch response.result {
            case .success(let product):
                 productData = ProductData(productName: product.productName, productPrice: product.productPrice, productDescription: product.productDescription)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func requestReviews() {
        // test getReviews
        let review = RequestFactory.shared.makeReviewRequestFactory()
        review.getReviews(idProduct: productId) { response in
            switch response.result {
            case .success(let reviews):
                reviewsData = reviews.map{ result -> ReviewData in
                    return ReviewData(idUser: result.idUser, text: result.text)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }

    }
}

struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        ProductView(productId: 0)
    }
}

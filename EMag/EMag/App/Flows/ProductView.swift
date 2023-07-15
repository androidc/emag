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

struct ProductView: View {
    // MARK: Vars
    var productId: Int
    @State var productData: ProductData?
    @State var reviewsData: [ReviewData] = []
    
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
                        
                    }
                }
                Section(header: Text("Отзывы")) {
                    List(reviewsData){ review in
                        ReviewRow(review: review)
                    }
                }
            }
          
        }.onAppear{
            requestProduct()
            requestReviews()
        }
            
    }
    
    private func productPriceDescription(price: Int?) -> String {
        let productPrice = price ?? -1
        return  productPrice == -1 ?  "N/A" : "\(productPrice)"
    }
    
    func requestProduct() {
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
    
    func requestReviews() {
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
//        review.getReviews(idProduct: 1) { response in
//            switch response.result {
//            case .success(let reviews):
//                print(reviews)
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
    }
}

struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        ProductView(productId: 0)
    }
}

//Created by chizztectep on 12.07.2023 

import SwiftUI
import Alamofire

struct CatalogData: Identifiable{
    let id = UUID()
    let productId:Int
    let name: String
    let price: Int
}


// A view that shows the data for one Restaurant.
struct ProductRow: View {
    var product: CatalogData

    var body: some View {
        HStack {
            Text(product.name)
            Text("\(product.price)")
        }
    }
}


struct CatalogView: View {
    
//    let products = [CatalogData(productId: 1, name: "Ноутбук", price: 100),
//                    CatalogData(productId: 2, name: "Планшет", price: 200)]
    
    @State var catalogProducts: [CatalogData] = []
    // MARK: - Vars
    var dismissAction: (() -> Void)
    var body: some View {
        
        NavigationView {
            List(catalogProducts){ product in
                ProductRow(product: product)
            }
        }.onAppear{
            mapProducts()
        }
    }
     func mapProducts()  {
        let catalog = RequestFactory.shared.makeCatalogRequestFactory()
        catalog.getCatalog(pageNumber: 1, idCategory: 1) { [self] response in
            switch response.result {
            case .success(let response):
                catalogProducts =  response.map { result -> CatalogData in
                    return CatalogData(productId: result.idProduct, name: result.productName, price: result.price)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

struct CatalogView_Previews: PreviewProvider {
    static var previews: some View {
        CatalogView{}
    }
}

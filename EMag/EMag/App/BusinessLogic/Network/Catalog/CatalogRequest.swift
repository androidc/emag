//Created by chizztectep on 18.06.2023 

import Foundation
import Alamofire

class Catalog: AbstractRequestFactory {
    let errorParser: AbstractErrorParser
    let sessionManager: Session
    let queue: DispatchQueue
   /* let baseUrl = URL(string:"https://raw.githubusercontent.com/GeekBrainsTutorial/online-store-api/master/responses/")! */
    
    let baseUrl = URL(string:"http://127.0.0.1:8080/")!
    
    init(
        errorParser: AbstractErrorParser,
        sessionManager: Session,
        queue: DispatchQueue = DispatchQueue.global(qos: .utility)) {
            self.errorParser = errorParser
            self.sessionManager = sessionManager
            self.queue = queue
        }
}

extension Catalog: CatalogRequestFactory {
   
   
    func getCatalog(pageNumber: Int, idCategory: Int, completionHandler: @escaping (AFDataResponse<[catalogResult]>) -> Void) {
        let requestModel = catalogData(baseUrl: baseUrl, pageNumber: pageNumber, idCategory: idCategory)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func getProductById(idProduct: Int, completionHandler: @escaping (AFDataResponse<Product>) -> Void) {
        let requestModel = productData(baseUrl: baseUrl, idProduct: idProduct)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
}

extension Catalog {
    struct catalogData: RequestRouter {
                    let baseUrl: URL
                    let method: HTTPMethod = .post
                    let path: String = "catalogData.json"
                    let pageNumber: Int
                    let idCategory: Int
                    var parameters: Parameters? {
                            return [
                                "page_number": pageNumber,
                                "id_category": idCategory
                            ]
                            }
                    }
    
    struct productData: RequestRouter{
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "getGoodById.json"
        let idProduct: Int
        
        var parameters: Parameters? {
                return [
                    "id_product": idProduct
                ]
                }
    }
    
    
}


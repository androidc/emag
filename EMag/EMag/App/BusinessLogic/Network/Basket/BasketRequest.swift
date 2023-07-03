//Created by chizztectep on 03.07.2023

import Alamofire


class Basket: AbstractRequestFactory {
    let errorParser: AbstractErrorParser
    let sessionManager: Session
    let queue: DispatchQueue

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

extension Basket: BasketRequestFactory {
   
    
    func addBasket(productId: Int, quantity: Int, completionHandler: @escaping (Alamofire.AFDataResponse<AddBasketResult>) -> Void) {
        let requestModel = BasketData(baseUrl: baseUrl, productId: productId, quantity: quantity)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func removeBasket(productId: Int, completionHandler: @escaping (Alamofire.AFDataResponse<CommonBasketResult>) -> Void) {
        let requestModel = RemoveBasketData(baseUrl: baseUrl, productId: productId)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func payBasket(userId: Int, completionHandler: @escaping (Alamofire.AFDataResponse<CommonBasketResult>) -> Void) {
        let requestModel = PayBasketData(baseUrl: baseUrl, userId: userId)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}



extension Basket {
    struct BasketData: RequestRouter {
                    let baseUrl: URL
                    let method: HTTPMethod = .post
                    let path: String = "addBasket.json"
                    let productId: Int
                    let quantity: Int
                    var parameters: Parameters? {
                            return [
                                "id_product": productId,
                                "quantity": quantity
                            ]
                            }
                    }
    
    struct RemoveBasketData: RequestRouter {
                    let baseUrl: URL
                    let method: HTTPMethod = .post
                    let path: String = "removeBasket.json"
                    let productId: Int
                    var parameters: Parameters? {
                            return [
                                "id_product": productId
                            ]
                            }
                    }
    
    struct PayBasketData: RequestRouter {
                    let baseUrl: URL
                    let method: HTTPMethod = .post
                    let path: String = "payBasket.json"
                    let userId: Int
                    var parameters: Parameters? {
                            return [
                                "id_user": userId
                            ]
                            }
                    }
    
    
}

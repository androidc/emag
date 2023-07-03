//Created by chizztectep on 03.07.2023
// v 1.0.0 lesson6
import Alamofire

protocol BasketRequestFactory {
    func addBasket(productId: Int, quantity: Int, completionHandler: @escaping
               (AFDataResponse<AddBasketResult>) -> Void)
    
    func removeBasket(productId: Int, completionHandler: @escaping
                      (AFDataResponse<CommonBasketResult>) -> Void)
    
    func payBasket(userId: Int, completionHandler: @escaping
                      (AFDataResponse<CommonBasketResult>) -> Void)
    
}

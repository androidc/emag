//Created by chizztectep on 18.06.2023 

import Foundation
import Alamofire

protocol CatalogRequestFactory {
    func getCatalog(pageNumber: Int, idCategory: Int, completionHandler: @escaping
               (AFDataResponse<[catalogResult]>) -> Void)
    
    func getProductById(idProduct: Int,  completionHandler: @escaping
               (AFDataResponse<Product>) -> Void)
}


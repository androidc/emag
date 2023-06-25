// Created by chizztectep on 18.06.2023

import Alamofire
import Foundation


protocol CatalogRequestFactory {
    func getCatalog(pageNumber: Int, idCategory: Int, completionHandler: @escaping
               (AFDataResponse<[CatalogResult]>) -> Void)
    func getProductById(idProduct: Int, completionHandler: @escaping
               (AFDataResponse<Product>) -> Void)
}

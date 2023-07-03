//Created by chizztectep on 18.06.2023 

import Foundation

/*
 [
   {
     "id_product": 123,
     "product_name": "Ноутбук",
     "price": 45600
   },
   {
     "id_product": 456,
     "product_name": "Мышка",
     "price": 1000
   }
 ]
 */

struct CatalogResult: Codable {
    let idProduct: Int
    let productName: String
    let price: Int
    
    enum CodingKeys: String, CodingKey {
        case idProduct = "id_product"
        case productName = "product_name"
        case price
    }
}

/*
 {
   "result": 1,
   "product_name": "Ноутбук",
   "product_price": 45600,
   "product_description": "Мощный игровой ноутбук"
 }
 */

struct Product: Codable {
    let result: Int
    let productName: String
    let productPrice: Int
    let productDescription: String
    
    enum CodingKeys: String, CodingKey {
        case result
        case productName = "product_name"
        case productPrice = "product_price"
        case productDescription = "product_description"
    }
}

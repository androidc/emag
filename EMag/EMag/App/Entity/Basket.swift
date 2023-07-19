//Created by chizztectep on 03.07.2023
// v 1.0.0 lesson6
import Foundation


struct AddBasketResult: Codable {
    let result: Int
}

struct CommonBasketResult: Codable {
    let result: Int
}

struct GetBasketResult: Codable {
    let price: Int
    let id_product: Int
    let quantity: Int
    let name: String
}



// Created by chizztectep on 12.06.2023

import Foundation

struct User: Codable {
    let id: Int
    let login: String
    let lastname: String
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id_user"
        case login = "user_login"
        case lastname = "user_lastname"
        case name = "user_name"
    }
}

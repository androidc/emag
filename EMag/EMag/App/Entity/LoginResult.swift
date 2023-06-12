//Created by chizztectep on 12.06.2023 

import Foundation

struct LoginResult: Codable {
    let result: Int
    let user: User
}

struct LogoutResult: Codable {
    let result: Int
}


struct RegisterResult: Codable {
    let result: Int
    let userMessage: String
}

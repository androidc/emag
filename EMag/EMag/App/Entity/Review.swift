// Created by chizztectep on 25.06.2023

import Foundation

struct ReviewResult: Codable {
    let idUser: Int
    let idComment: Int
    let text: String
  
    enum CodingKeys: String, CodingKey {
        case idUser = "id_user"
        case idComment = "id_comment"
        case text = "text"
    }
}

struct AddReviewResult: Codable {
    let result: Int
    let userMessage: String
    let errorMessage: String?
}

struct RemoveReviewResult: Codable {
    let result: Int
    let errorMessage: String?
}

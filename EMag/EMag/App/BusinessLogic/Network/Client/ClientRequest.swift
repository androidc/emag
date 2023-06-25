// Created by chizztectep on 12.06.2023

import Alamofire
import Foundation


class Client: AbstractRequestFactory {
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

extension Client: ClientRequestFactory {
    func changeUser(idUser: Int, username: String, password: String, email: String,                 gender: String, creditCard: String, bio: String,
                   completionHandler: @escaping (AFDataResponse<ChangeUserResult>) -> Void) {
        let requestModel = ChangeUser(baseUrl: baseUrl, idUser: idUser,username: username, password: password, email: email, gender: gender, creditCard: creditCard, bio: bio)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}
extension Client {
    struct ChangeUser: RequestRouter {
            let baseUrl: URL
            let method: HTTPMethod = .post
            let path: String = "changeUserData.json"
            let idUser: Int
            let username: String
            let password: String
            let email: String
            let gender: String
            let creditCard: String
            let bio: String
            var parameters: Parameters? {
                    return [
                        "id_user": idUser,
                        "username": username,
                        "password": password,
                        "email": email,
                        "gender": gender,
                        "credit_card": creditCard,
                        "bio": bio
                    ]
                    }
        }
}

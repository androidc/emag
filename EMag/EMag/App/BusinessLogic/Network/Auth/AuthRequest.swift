//Created by chizztectep on 12.06.2023 

import Foundation
import Alamofire

class Auth: AbstractRequestFactory {
    let errorParser: AbstractErrorParser
    let sessionManager: Session
    let queue: DispatchQueue
  /*  let baseUrl = URL(string:"https://raw.githubusercontent.com/GeekBrainsTutorial/online-store-api/master/responses/")!
   */
    
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
        
extension Auth: AuthRequestFactory {
   
    
   
    
    func login(userName: String, password: String, completionHandler: @escaping
    (AFDataResponse<LoginResult>) -> Void) {
        let requestModel = Login(baseUrl: baseUrl, login: userName, password: password)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func logout(idUser: Int, completionHandler: @escaping (AFDataResponse<LogoutResult>) -> Void) {
        let requestModel = Logout(baseUrl: baseUrl, idUser: idUser)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func register(idUser: Int, username: String, password: String, email: String, gender: String, creditCard: String, bio: String, completionHandler: @escaping (AFDataResponse<RegisterResult>) -> Void) {
        let requestModel = Register(baseUrl: baseUrl, idUser: idUser,username: username, password: password, email: email, gender: gender, creditCard: creditCard, bio: bio)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    
}

extension Auth {
    struct Login: RequestRouter {
                    let baseUrl: URL
                    let method: HTTPMethod = .post
                    let path: String = "login.json"
                    let login: String
                    let password: String
                    var parameters: Parameters? {
                            return [
                                "username": login,
                                "password": password
                            ]
                            }
                    }
    
    struct Logout: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "logout.json"
        let idUser: Int
        var parameters: Parameters? {
                return [
                    "id_user": idUser
                ]
                }
        }
    

struct Register: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "registerUser.json"
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

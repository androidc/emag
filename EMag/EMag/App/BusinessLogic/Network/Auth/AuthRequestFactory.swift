//Created by chizztectep on 12.06.2023 

import Foundation
import Alamofire

protocol AuthRequestFactory {
    func login(userName: String, password: String, completionHandler: @escaping
               (AFDataResponse<LoginResult>) -> Void)
    
    func logout(idUser: Int, completionHandler: @escaping
               (AFDataResponse<LogoutResult>) -> Void)
    
    func register(idUser:Int,username: String, password: String, email:String, gender: String, creditCard: String, bio: String, completionHandler: @escaping
                  (AFDataResponse<RegisterResult>) -> Void)
}


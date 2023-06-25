//Created by chizztectep on 12.06.2023 

import Alamofire
import Foundation


protocol ClientRequestFactory {
    func changeUser(idUser: Int,username: String, password: String,
                    email: String,
                    gender: String,
                    creditCard: String,
                    bio: String,
                    completionHandler: @escaping
                  (AFDataResponse<ChangeUserResult>) -> Void)
}

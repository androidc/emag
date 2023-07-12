//Created by chizztectep on 05.07.2023 

import Alamofire
// фигня полная, зачем сделано непонятно, надо рефакторить
class AuthMethods {
    let auth = RequestFactory.shared.makeAuthRequestFatory()
    
    func login(username: String, password: String, completion: @escaping (LoginResult?) -> Void) {
        auth.login(userName: username, password: password) { response in
            switch response.result {
            case .success(let login):
                completion(login)
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil)
            }
        }
    }

    func register(idUser: Int, username: String,
                       password: String, email: String, gender: String,
                       creditCard: String,
                  bio: String, completion: @escaping (RegisterResult?, AFError?) -> Void) {
        auth.register(idUser: idUser, username: username, password: password, email: email, gender: gender, creditCard: creditCard, bio: bio) { response in
            switch response.result {
            case .success(let register):
                completion(register,nil)
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil,error)
            }
        }
    }
}

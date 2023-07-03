//Created by chizztectep on 28.06.2023 



class AuthTest {
    private var userId: Int = 0
    
    init() {
        let auth = RequestFactory.shared.makeAuthRequestFatory()
          // test login
        auth.login(userName: "Somebody", password: "mypassword") { [self] response in
            print(response)
            print(response.response?.statusCode)
            switch response.result {
            case .success(let login):
                print(login)
                self.userId = login.user.id
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
         // test logout
         auth.logout(idUser: self.userId) { response in
                switch response.result {
                case .success(let response):
                    print(response.result)
                    print("logout success")
                case .failure(let error):
                print(error.localizedDescription)
                }
         }
        // test register
         auth.register(idUser: self.userId, username: "Somebody",
                       password: "mypassword", email: "some@some.ru", gender: "m",
                       creditCard: "9872389-2424-234224-234",
                       bio: "This is good! I think I will switch to another language") { [self] response in
                switch response.result {
                case .success(let response):
                    print(response.result)
                case .failure(let error):
                    print(error.localizedDescription)
            }
         }
    }
}

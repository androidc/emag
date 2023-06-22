//Created by chizztectep on 11.06.2023 

import UIKit

// https:/ /github.com/GeekBrainsTutorial/online-store-api

class ViewController: UIViewController {
    private var userId: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
      
        
        let auth = RequestFactory.shared.makeAuthRequestFatory()
        // test login
        auth.login(userName: "Somebody", password: "mypassword") { [self] response in
            switch response.result {
                case .success(let login):
                print(login)
                self.userId = login.user.id
              case .failure(let error):
            print(error.localizedDescription)
        }
         // test logout
         auth.logout(idUser: self.userId) { [self] response in
                switch response.result {
                    case .success(let response):
                    print(response.result)
                  
                  case .failure(let error):
                print(error.localizedDescription)
            }
            }
            
        // test register
            auth.register(idUser: self.userId, username: "Somebody", password: "mypassword", email: "some@some.ru", gender: "m", creditCard: "9872389-2424-234224-234", bio: "This is good! I think I will switch to another language") { [self] response in
                switch response.result {
                    case .success(let response):
                    print(response.result)
                  
                  case .failure(let error):
                print(error.localizedDescription)
            }
            }
 
            // test change userdata
            let client = RequestFactory.shared.makeClientRequestFactory()
            client.changeUser(idUser: self.userId, username: "Somebody", password: "mypassword", email: "some@some.ru", gender: "m", creditCard: "9872389-2424-234224-234", bio: "This is good! I think I will switch to another language") { [self] response in
                switch response.result {
                    case .success(let response):
                    print(response.result)
                  
                  case .failure(let error):
                print(error.localizedDescription)
            }
            }
            
            //test getCatalog
            let catalog = RequestFactory.shared.makeCatalogRequestFactory()
            catalog.getCatalog(pageNumber: 1, idCategory: 1) { [self] response in
               
                switch response.result {
                
                case .success(let response):
                    for resp in response {
                        print(resp.idProduct)
                    }
                case .failure(let error) :
                    print(error.localizedDescription)
                }
            }
            
            // test getProductById
            catalog.getProductById(idProduct: 1) {[self] response in
                switch response.result {
                case .success(let product) :
                    print(product)
                case .failure(let error) :   print(error.localizedDescription)
                }
            }
            


        }

}
}

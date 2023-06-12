//Created by chizztectep on 11.06.2023 

import UIKit

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
 


        }

}
}

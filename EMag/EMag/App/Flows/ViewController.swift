// Created by chizztectep on 11.06.2023
// v 1.0.0 lesson6
import UIKit
import SwiftUI

// https:/ /github.com/GeekBrainsTutorial/online-store-api
// https://stackoverflow.com/questions/57190511/dismiss-a-swiftui-view-that-is-contained-in-a-uihostingcontroller

class ViewController: UIViewController {
    
    private var registerView: UIHostingController<RegisterView>?
    
    private var user: LoginResult?
    
    // MARK: - Outlets
    @IBOutlet private weak var loginTextInput: UITextField!
    @IBOutlet weak var passwordTextInput: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    @IBAction func loginButtonAction(_ sender: UIButton) {
        // сделать запрос на авторизацию
        let authController = AuthMethods()
        authController.login(username: loginTextInput.text!, password: passwordTextInput.text!) { result in
            guard let result  else {
                // выводим сообщение о том, что не получилось зайти
                print("error login")
                return
            }
            // переходим на экран с данными пользователя
            print("ok login: \(result.user.id)")
            self.user = result
            DispatchQueue.main.async { self.performSegue(withIdentifier: "successLogin", sender: self)
            }
        }
    }
    

    
    @IBAction func registerButtonAction(_ sender: Any) {
        present(registerView!, animated: true)
    }
    
    private var userId: Int = 0
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         guard segue.identifier == "successLogin" else { return }
         guard let destination = segue.destination as? UserViewController else { return }
        destination.user = self.user
     }
 

    override func viewDidLoad() {
        super.viewDidLoad()
        
       registerView = UIHostingController(rootView: RegisterView(dismissAction: {
            self.dismiss(animated: true, completion: nil)
        }))
   
        
        
            // test change userdata
            let client = RequestFactory.shared.makeClientRequestFactory()
            client.changeUser(idUser: self.userId, username: "Somebody", password: "mypassword", email: "some@some.ru",
                              gender: "m", creditCard: "9872389-2424-234224-234",
                              bio: "This is good! I think I will switch to another language") { [self] response in
                switch response.result {
                case .success(let response):
                    print(response.result)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            // test getCatalog
            let catalog = RequestFactory.shared.makeCatalogRequestFactory()
        catalog.getCatalog(pageNumber: 1, idCategory: 1) {  response in
            switch response.result {
            case .success(let response):
                for resp in response {
                    print(resp.idProduct)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
            // test getProductById
        catalog.getProductById(idProduct: 1) { response in
            switch response.result {
            case .success(let product):
                print(product)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        // test getReviews
        let review = RequestFactory.shared.makeReviewRequestFactory()
        review.getReviews(idProduct: 1) { response in
            switch response.result {
            case .success(let reviews):
                print(reviews)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
 
        // test addReview
        review.addReview(idUser: 123, text: "jjj") { response in
            switch response.result {
            case .success(let reviews):
                print(reviews)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }

        // test addReview with error
        review.addReview(idUser: 1, text: "jjj") { response in
            switch response.result {
            case .success(let reviews):
                print(reviews)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        // test removeReview
        review.removeReview(idComment: 123) { response in
            switch response.result {
            case .success(let response):
                print("remove success")
                print(response)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        // test Basket
    //  let basket = RequestFactory.shared.makeBasketRequestFactory()
      
//      basket.addBasket(productId: 1, quantity: 2) { response in
//          switch response.result {
//
//          case .success(let response):
//              print(response)
//          case .failure(let error) :
//              print(error.localizedDescription)
//          }
//      }
  
//      basket.removeBasket(productId: 1) { response in
//          switch response.result {
//          case .success(let response):
//              print(response)
//          case .failure(let error) :
//              print(error.localizedDescription)
//          }
//      }
      
//      basket.payBasket(userId: 1) { response in
//          switch response.result {
//          case .success(let response):
//              print(response)
//          case .failure(let error) :
//              print(error.localizedDescription)
//          }
//      }
        
    }
}

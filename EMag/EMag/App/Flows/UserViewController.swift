//Created by chizztectep on 05.07.2023 

import UIKit
import SwiftUI
class UserViewController: UIViewController{
    
    var user: LoginResult?
    private var catalogView: UIHostingController<CatalogView>?
    
    @IBOutlet weak var lastNameField: UILabel!
    @IBOutlet weak var nameField: UILabel!
    
    
    @IBAction func CatalogButtonAction(_ sender: Any) {
        present(catalogView!, animated: true)
    }
    
    @IBAction func logoutButtonAction(_ sender: Any) {
        let auth = RequestFactory.shared.makeAuthRequestFactory()
        // test logout
        auth.logout(idUser: (user?.user.id)!) { response in
               switch response.result {
               case .success(let response):
                   print(response.result)
                   print("logout success")
               case .failure(let error):
               print(error.localizedDescription)
               }
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        
        if let user {
            self.nameField.text = user.user.name
            self.lastNameField.text = user.user.lastname
        }
        
        catalogView = UIHostingController(rootView: CatalogView(dismissAction: {
             self.dismiss(animated: true, completion: nil)
         }))
    }
}

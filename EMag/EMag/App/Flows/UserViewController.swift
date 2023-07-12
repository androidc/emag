//Created by chizztectep on 05.07.2023 

import UIKit
class UserViewController: UIViewController{
    
    var user: LoginResult?
    
    @IBOutlet weak var lastNameField: UILabel!
    @IBOutlet weak var nameField: UILabel!
    override func viewDidLoad() {
        
        if let user {
            self.nameField.text = user.user.name
            self.lastNameField.text = user.user.lastname
        }
    }
}

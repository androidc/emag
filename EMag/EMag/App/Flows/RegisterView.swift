//Created by chizztectep on 07.07.2023 

import SwiftUI

struct RegisterView: View {
    
    // MARK: - Vars
    var dismissAction: (() -> Void)
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var email: String = ""
    @State private var creditCard: String = ""
    @State private var bio: String = "bio:"
    @State private var textStyle = UIFont.TextStyle.body
    @State private var selectedGender = "Male"
    let genders = ["Male", "Female"]
    
    // MARK: - Functions

    
//    func register() {
//
//    }
    
    // MARK: - body
    var body: some View {
        NavigationView {
                   Form {
                    
                       Section {
                           
                           TextField("UserName", text: $username).padding(10)
                           SecureField("Password", text: $password).padding(10)
                           TextField("Email", text: $email).padding(10)
                           Picker("Gender",selection: $selectedGender) {
                               ForEach(genders, id: \.self) {
                                   Text($0)
                               }
                           }.padding(10)
                           TextField("CreditCard", text: $creditCard).padding(10)
                       }
                       Section {
                           TextView(text: $bio, textStyle: $textStyle)
                               .padding(.horizontal)
                               
                       }
                       Section {
                           Button("Register", action: {
                               
                               // TODO: проверки на заполнение полей и алерты
                               // TODO: проверка что такой пользователь уже "существует" (доработка vapor)
                               let idUser = Int.random(in: 1..<10000)
                               AuthMethods().register(idUser: idUser, username: username, password: password, email: email, gender: selectedGender, creditCard: creditCard, bio: bio) { result, error in
                                   guard let result else {
                                       print(error?.localizedDescription)
                                       return
                                   }
                                   print(result)
                                   DispatchQueue.main.async { dismissAction() }
                               }
                           })
                           Button("Dismiss", action: dismissAction)
                       }
                   }
                   .navigationBarTitle("Register")
               }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView {}
    }
}

struct TextView: UIViewRepresentable {
    
    @Binding var text: String
    @Binding var textStyle: UIFont.TextStyle
 
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.font = UIFont.preferredFont(forTextStyle: textStyle)
        textView.autocapitalizationType = .sentences
        textView.isSelectable = true
        textView.isUserInteractionEnabled = true
        textView.isScrollEnabled = false
 
        return textView
    }
 
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
        uiView.font = UIFont.preferredFont(forTextStyle: textStyle)
    }
}

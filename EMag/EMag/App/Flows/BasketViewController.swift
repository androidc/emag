//Created by chizztectep on 18.07.2023 

import UIKit

class BasketViewController: UIViewController {
    
    var userBasket: [GetBasketResult] = []
    var userId: Int? 

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var sumLabel: UILabel!
    
    @IBAction func payBasketAction(_ sender: Any) {
        let basket = RequestFactory.shared.makeBasketRequestFactory()
        basket.payBasket(userId: userId!,paymentSum: self.getSum(basket: self.userBasket)) { response in
            switch response.result {
            case .success(let result):
                DispatchQueue.main.async {
                    // выходим из корзины
                    self.navigationController?.popViewController(animated: true)
                }
                
            case .failure(let error):
                DispatchQueue.main.async {
                    // Create new Alert
                    var dialogMessage = UIAlertController(title: "Error", message: "Error payment \(error.localizedDescription)", preferredStyle: .alert)
                    
                    // Create OK button with action handler
                    let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                        print("Ok button tapped")
                     })
                    
                    //Add OK button to a dialog message
                    dialogMessage.addAction(ok)

                    // Present Alert to
                    self.present(dialogMessage, animated: true, completion: nil)
                }
               
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        getBasket {
            DispatchQueue.main.async {
                self.sumLabel.text = "Сумма: \(self.getSum(basket: self.userBasket))"
                self.tableView.reloadData()
            }
        }

        // Do any additional setup after loading the view.
    }
    
    /// функция возвращает сумму цен товаров в корзине
    private func getSum(basket: [GetBasketResult] ) -> Int {
         basket.reduce(0) {$0 + $1.price}
    }
    
    private func getBasket(completion: @escaping () -> Void) {
        let basket = RequestFactory.shared.makeBasketRequestFactory()
        basket.getBasket(userId: userId!) { response in
            switch response.result {
            case .success(let basket): self.userBasket = basket
                                       completion()
            case .failure(let error) : print(error.localizedDescription)
            }
        }
        
    }

}

extension BasketViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userBasket.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
        cell.textLabel?.text = "\(userBasket[indexPath.row].name)"
        cell.detailTextLabel?.text = "\(userBasket[indexPath.row].price)"
        return cell
    }
    
    
}

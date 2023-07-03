//Created by chizztectep on 25.06.2023 

import Alamofire
import Foundation


class ReviewRequest: AbstractRequestFactory {
    let errorParser: AbstractErrorParser
    let sessionManager: Session
    let queue: DispatchQueue
  
    let baseUrl = URL(string:"http://127.0.0.1:8080/")!
    init(
        errorParser: AbstractErrorParser,
        sessionManager: Session,
        queue: DispatchQueue = DispatchQueue.global(qos: .utility)) {
            self.errorParser = errorParser
            self.sessionManager = sessionManager
            self.queue = queue
        }
}

extension ReviewRequest: ReviewRequestFactory {
    
    func removeReview(idComment: Int, completionHandler: @escaping (Alamofire.AFDataResponse<RemoveReviewResult>) -> Void) {
        let requestModel = RemoveReviewData(baseUrl: baseUrl, idComment: idComment)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    
    func getReviews(idProduct: Int, completionHandler: @escaping (Alamofire.AFDataResponse<[ReviewResult]>) -> Void) {
        let requestModel = ReviewData(baseUrl: baseUrl, idProduct: idProduct)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func addReview(idUser: Int, text: String, completionHandler: @escaping (Alamofire.AFDataResponse<AddReviewResult>) -> Void) {
        let requestModel = AddReviewData(baseUrl: baseUrl, idUser: idUser, text: text)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
}


extension ReviewRequest {
    struct ReviewData: RequestRouter {
                    let baseUrl: URL
                    let method: HTTPMethod = .post
                    let path: String = "getReviews.json"
                    let idProduct: Int
                    var parameters: Parameters? {
                            return [
                                "id_product": idProduct
                            ]
                            }
                    }
    
    struct RemoveReviewData: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "removeReview.json"
        let idComment: Int
        var parameters: Parameters? {
                return [
                    "id_comment": idComment
                ]
                }
    }
    
    struct AddReviewData: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "addReview.json"
        let idUser: Int
        let text: String
        var parameters: Parameters? {
                return [
                    "id_user": idUser,
                    "text": text
                ]
                }
    }
}

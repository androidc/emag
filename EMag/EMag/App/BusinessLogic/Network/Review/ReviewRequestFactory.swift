
import Alamofire
import Foundation


protocol ReviewRequestFactory {
    func getReviews(idProduct: Int, completionHandler: @escaping
               (AFDataResponse<[ReviewResult]>) -> Void)
    func addReview(idUser: Int, text: String, completionHandler: @escaping
                   (AFDataResponse<AddReviewResult>) -> Void)
    func removeReview(idComment: Int, completionHandler: @escaping
                      (AFDataResponse<RemoveReviewResult>) -> Void)
}

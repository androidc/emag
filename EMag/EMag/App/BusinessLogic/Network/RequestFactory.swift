//Created by chizztectep on 12.06.2023 

import Foundation
import Alamofire

class RequestFactory {
    func makeErrorParser() -> AbstractErrorParser {
        return ErrorParser()
    }
    
  public lazy var commonSession: Session = {
        
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = true
        configuration.headers = .default
        configuration.timeoutIntervalForRequest = 30
        let manager = Session(configuration: configuration)
        return manager
    }()
    
//    func newSession() -> Session {
//        let configuration = URLSessionConfiguration.default
//        configuration.httpShouldSetCookies = true
//        configuration.headers = .default
//        let manager = Session(configuration: configuration)
//        return manager
//    }
    
    let sessionQueue = DispatchQueue.global(qos: .utility)
    
    func makeAuthRequestFatory() -> AuthRequestFactory {
        let errorParser = makeErrorParser()
        //let newSession = newSession()
        return Auth(errorParser: errorParser, sessionManager: commonSession,
                    queue: sessionQueue)
    }
    
    private init() { }
    static let shared = RequestFactory()
    
    
}

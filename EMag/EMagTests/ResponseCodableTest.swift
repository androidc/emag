//Created by chizztectep on 14.06.2023 

import XCTest
import Alamofire
@testable import EMag

struct PostStub: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
enum ApiErrorStub: Error {
    case fatalError
}
struct ErrorParserStub: AbstractErrorParser {
    func parse(_ result: Error) -> Error {
            return ApiErrorStub.fatalError
    }
func parse(response: HTTPURLResponse?, data: Data?, error: Error?) -> Error?
    {
    return error
    }
}

class ResponseCodableTest: XCTestCase {
    
    let expectation = XCTestExpectation(description: "Download https://failUrl")
    var errorParser: ErrorParserStub!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func setUp() {
        super.setUp()
        errorParser = ErrorParserStub()
        
    }
    
    override func tearDown() {
        super.tearDown()
        errorParser = nil
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testShouldDownloadAndParse() {
       // let errorParser = ErrorParserStub()
        
        AF.request("https://jsonplaceholder.typicode.com/posts/1")
        .responseCodable(errorParser: errorParser) { [weak self] (response:
           AFDataResponse<PostStub>) in
            switch response.result {
                case .success(_): break
                case .failure:
                    XCTFail()
                }
            self?.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

//Created by chizztectep on 25.06.2023 

import XCTest
@testable import EMag

final class ReviewTests: XCTestCase {
    let expectation = XCTestExpectation(description: "getReviews passed")
    let expectation1 = XCTestExpectation(description: "addReviews passed")
    
    var reviewFactory: ReviewRequestFactory?
    
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        reviewFactory = RequestFactory.shared.makeReviewRequestFactory()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

   
    func testGetReiews() throws {
        // When
        reviewFactory?.getReviews(idProduct: 123, completionHandler: { [weak self] response in
            switch response.result {

            case .success(let response):
                //Then
                XCTAssertGreaterThan(response.count, 1)
            case .failure(let error) :
                XCTFail()
            }
            self?.expectation.fulfill()
        }
        
        )
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testAddReview() throws {
        // When
        reviewFactory?.addReview(idUser: 123, text: "ok", completionHandler: { [weak self] response in
            switch response.result {

            case .success(let response):
                //Then
                XCTAssertEqual(response.result, 1)
            case .failure(let error) :
                XCTFail()
            }
            self?.expectation1.fulfill()
        })
        wait(for: [expectation1], timeout: 10.0)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

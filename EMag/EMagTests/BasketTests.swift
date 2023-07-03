//Created by chizztectep on 03.07.2023

import XCTest
@testable import EMag

final class BasketTests: XCTestCase {
    let expectation1 = XCTestExpectation(description: "addBasket passed")
    var basketFactory: BasketRequestFactory?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        basketFactory = RequestFactory.shared.makeBasketRequestFactory()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAddBasket() throws {
        
        basketFactory?.addBasket(productId: 1, quantity: 1){ [weak self] response in
            switch response.result {
            case .success(let response):
                //Then
               XCTAssertEqual(response.result, 1)
            case .failure(let error):
                XCTFail()
            }
            self?.expectation1.fulfill()
        }
        wait(for: [expectation1], timeout: 10.0)
        
        
    
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

//Created by chizztectep on 18.06.2023 

import XCTest
@testable import EMag

class ClientTests: XCTestCase {
    let expectation = XCTestExpectation(description: "changeUser passed")
    var clientFactory: ClientRequestFactory?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        clientFactory = RequestFactory.shared.makeClientRequestFactory()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        clientFactory = nil
    }

   
    
    func testChangeUser() throws {
        // Given
        let userId = 123
        
        // When
        clientFactory?.changeUser(idUser: userId, username: "Somebody", password: "mypassword", email: "some@some.ru", gender: "m", creditCard: "9872389-2424-234224-234", bio: "This is good! I think I will switch to another language") { [weak self] response in
            switch response.result {
                case .success(let response):
                //Then
                XCTAssertEqual(response.result, 1)
              
              case .failure(let error):
                        XCTFail()
        }
            self?.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }

   

}

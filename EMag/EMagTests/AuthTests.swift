//Created by chizztectep on 17.06.2023 

import XCTest
@testable import EMag

class AuthTests: XCTestCase {
    
    let expectation = XCTestExpectation(description: "login passed")
    let expectation_logout = XCTestExpectation(description: "logout passed")
    let expectation_register = XCTestExpectation(description: "register passed")

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testBuildAuthLogin() throws {
 
        //Given
        let auth = RequestFactory.shared.makeAuthRequestFatory()
       
        // When
        auth.login(userName: "Somebody", password: "mypassword") { [weak self] response in
            switch response.result {
                case .success(let login):
                //Then
                XCTAssertEqual(login.user.id, 123)
                
              case .failure(let error):
                
                XCTFail()
            }
            self?.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
        
    }
    
    func testBuildAuthLogout() throws {
        //Given
        let auth = RequestFactory.shared.makeAuthRequestFatory()
        let idUser = 123
        
        auth.logout(idUser: idUser) { [weak self] response in
               switch response.result {
                   case .success(let response):
                   //Then
                   XCTAssertEqual(response.result, 1)
                 case .failure(let error):
                   XCTFail()
           }
            self?.expectation_logout.fulfill()
        }
        wait(for: [expectation_logout], timeout: 10.0)
    }
    
    func testBuildAuthRegister() throws {
        //Given
        let auth = RequestFactory.shared.makeAuthRequestFatory()
        let idUser = 123
        
        // test register
            auth.register(idUser: idUser, username: "Somebody", password: "mypassword", email: "some@some.ru", gender: "m", creditCard: "9872389-2424-234224-234", bio: "This is good! I think I will switch to another language") { [weak self] response in
                switch response.result {
                    case .success(let response):
                    XCTAssertEqual(response.result, 1)
                  
                  case .failure(let error):
                    XCTFail()
            }
                self?.expectation_register.fulfill()
            }
        wait(for: [expectation_register], timeout: 10.0)
    }
    
    

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}


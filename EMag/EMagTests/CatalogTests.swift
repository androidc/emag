//Created by chizztectep on 18.06.2023 

import XCTest
@testable import EMag

class CatalogTests: XCTestCase {
    let expectation1 = XCTestExpectation(description: "getCatalog passed")
    let expectation2 = XCTestExpectation(description: "getProduct passed")
    
    var catalogFactory: CatalogRequestFactory?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        catalogFactory = RequestFactory.shared.makeCatalogRequestFactory()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        catalogFactory = nil
    }

    func testGetCatalog() throws {
        
        // When
        catalogFactory?.getCatalog(pageNumber: 1, idCategory: 1) { [weak self] response in
           
            switch response.result {
            
            case .success(let response):
                //Then
                XCTAssertGreaterThan(response.count, 1)
            case .failure(let error) :
                XCTFail()
            }
            self?.expectation1.fulfill()
        }
        wait(for: [expectation1], timeout: 10.0)
    }
    
    func testGetProductById() throws {
        catalogFactory?.getProductById(idProduct: 1) {[weak self] response in
            switch response.result {
            case .success(let product) :
                XCTAssertEqual(product.result, 1)
                XCTAssertEqual(product.productName, "Ноутбук")
            case .failure(let error) :  XCTFail()
            }
            self?.expectation2.fulfill()
        }
        wait(for: [expectation2], timeout: 10.0)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

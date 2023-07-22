//Created by chizztectep on 11.06.2023 

import XCTest

class EMagUITests: XCTestCase {
    
    var app: XCUIApplication!
   
   

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        app = XCUIApplication()
        app.launch()
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testSuccess() throws {
        let loginLabel = app.textFields["AcIdLoginText"]
        XCTAssert(loginLabel.exists)
        
        let passwordLabel = app.textFields["AcIdPasswordLabel"]
        XCTAssert(passwordLabel.exists)
        
        loginLabel.tap()
        loginLabel.typeText("111")
        passwordLabel.tap()
        passwordLabel.typeText("111")
        let button = app.buttons["AcIdLoginButton"]
        XCTAssert(button.exists)
        
        // сначала проверяем, что кнопки еще нет
        var buttonCatalog = app.buttons["AcIdCatalogButton"]
        XCTAssert(!buttonCatalog.exists)
        
        // нажимаем кнопку и если пользователь авторизовался успешно, то должен появиться следующий экран с кнопками
        button.tap()
        buttonCatalog = app.buttons["AcIdCatalogButton"]
        XCTAssert(buttonCatalog.exists)
            
    }
    
    func testFail() throws {
        let loginLabel = app.textFields["AcIdLoginText"]
        XCTAssert(loginLabel.exists)
        
        let passwordLabel = app.textFields["AcIdPasswordLabel"]
        XCTAssert(passwordLabel.exists)
        
        loginLabel.tap()
        loginLabel.typeText("222")
        passwordLabel.tap()
        passwordLabel.typeText("222")
        let button = app.buttons["AcIdLoginButton"]
        XCTAssert(button.exists)
        
        // сначала проверяем, что кнопки еще нет
        var buttonCatalog = app.buttons["AcIdCatalogButton"]
        XCTAssert(!buttonCatalog.exists)
        
        // нажимаем кнопку и так как пользователь не авторизовался, то не должен появиться следующий экран с кнопками
        button.tap()
        buttonCatalog = app.buttons["AcIdCatalogButton"]
        XCTAssert(!buttonCatalog.exists)
            
        
        
        
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}

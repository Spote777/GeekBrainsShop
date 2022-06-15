//
//  GeekBrainsShopUITests.swift
//  GeekBrainsShopUITests
//
//  Created by Павел Заруцков on 20.04.2022.
//

import XCTest

class GeekBrainsShopUITests: XCTestCase {
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    override func tearDownWithError() throws { }
    
    func testSuccessfulLogin() throws {
        let app = XCUIApplication()
        app.launch()
        app.scrollViews.otherElements.buttons["Логин"].tap()
    }
    
    func testFailedLogin() throws {
        let app = XCUIApplication()
        app.launch()
        
        let elementsQuery = app.scrollViews.otherElements
        elementsQuery.textFields["Логин"].tap()
        elementsQuery.textFields["Логин"].clearAndEnterText(text: "Хэллоу")
        app.scrollViews.otherElements.buttons["Логин"].tap()
        
        XCTAssert(app.alerts.firstMatch.waitForExistence(timeout: 2.0))
    }
    
    func testCartCheckout() throws {
        let app = XCUIApplication()
        app.launch()
        
        func testLaunchPerformance() throws {
            if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
                measure(metrics: [XCTApplicationLaunchMetric()]) {
                    XCUIApplication().launch()
                }
            }
            let scrollViewsQuery = app.scrollViews
            app.scrollViews.otherElements.buttons["Логин"].tap()
            
            let tablesQuery = app.tables
            tablesQuery.staticTexts.firstMatch.tap()
            
            scrollViewsQuery.otherElements.firstMatch.swipeUp()
            scrollViewsQuery.otherElements.buttons["В корзину"].tap()
            
            app.alerts["Корзина"].scrollViews.otherElements.buttons["OK"].tap()
            
            app.navigationBars["Войти в магазин"].buttons["Cart"].tap()
            tablesQuery.buttons["Оформить покупку"].tap()
            
            app.alerts["Корзина"].scrollViews.otherElements.buttons["OK"].tap()
            
            XCTAssert(tablesQuery.staticTexts["Корзина пуста"].waitForExistence(timeout: 2.0))
        }
    }
}

extension XCUIElement {
    func clearAndEnterText(text: String) {
        guard let stringValue = self.value as? String else {
            XCTFail("Tried to clear and enter text into a non string value")
            return
        }
        
        self.tap()
        let deleteString = String(repeating: XCUIKeyboardKey.delete.rawValue, count: stringValue.count)
        self.typeText(deleteString)
        self.typeText(text)
    }
}

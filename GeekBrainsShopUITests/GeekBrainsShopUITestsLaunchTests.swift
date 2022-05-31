//
//  GeekBrainsShopUITestsLaunchTests.swift
//  GeekBrainsShopUITests
//
//  Created by Павел Заруцков on 20.04.2022.
//

import XCTest

class GeekBrainsShopUITestsLaunchTests: XCTestCase {
    
    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()
        
        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}

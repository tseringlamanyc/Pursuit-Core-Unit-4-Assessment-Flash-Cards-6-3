//
//  Unit4AssessmentTests.swift
//  Unit4AssessmentTests
//
//  Created by Alex Paul on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import XCTest
@testable import Unit4Assessment

class Unit4AssessmentTests: XCTestCase {
    
    func testCard() {
        let jsonData = """
        {
        "cardListType": "q and a",
        "apiVersion": "1.2.3",
        "cards": [
        {
        "id": "1",
        "cardTitle": "What is the difference between a synchronous & an asynchronous task?",
        "facts": [
        "Synchronous: waits until the task have completed.",
        "Asynchronous: completes a task in the background and can notify you when complete."
        ]
        },
        {
        "id": "2",
        "cardTitle": "What is an Enum?",
        "facts": [
        "contains a group of related values.",
        "enumerations define a finite number of states, and can bundle associated values with each individual state.",
        "you can use them to model the state of your app and its internal processes."
        ]
        },
        {
        "id": "3",
        "cardTitle": "What’s the difference between the frame and the bounds?",
        "facts": [
        "The frame of a UIView is the rectangle, expressed as a location (x,y) and size (width,height) relative to the superview it is contained within.",
        "The bounds of a UIView is the rectangle, expressed as a location (x,y) and size (width,height) relative to its own coordinate system (0,0)."
        ]
        }]
        }
        """.data(using: .utf8)!
        
        let expectedCount = 3
        
        do {
            let allCards = try JSONDecoder().decode(AllCards.self, from: jsonData)
            let count = allCards.cards.count
            print("\(count)")
            XCTAssertEqual(expectedCount, count)
        } catch {
            XCTFail("\(error)")
        }
        
    }
    
}

//
//  ArrayTests.swift
//  MovieQuizTests
//
//  Created by Nikolay Kozlov on 18.06.2023.
//

import XCTest
@testable import MovieQuiz

class ArrayTests: XCTestCase {
    
    func testGetValueInGivenRange() {
        // Given
        let array = [1,1,2,3,5]
               
        // When
        let value = array[safe: 2]
               
        // Then
        XCTAssertNotNil(value)
        XCTAssertEqual(value, 2)
    }
    
    func testGetValueOutOfRange() {
        // Given
        let array = [1,1,2,3,5]
               
        // When
        let value = array[safe: 20]
               
        // Then
        XCTAssertNil(value)
    }
    
}

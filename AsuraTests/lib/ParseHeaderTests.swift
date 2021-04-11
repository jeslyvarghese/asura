//
//  ParseHeaderTests.swift
//  AsuraTests
//
//  Created by Jesly Varghese on 05/04/21.
//

import XCTest
@testable import Asura


class ParseHeaderTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }


    func testFlattenUInt8ToUInt32() {
        let byteArray: [UInt8] = [UInt8.max, UInt8.max, UInt8.max, UInt8.max]
        let flattened: UInt32 = flatten(byteArray)
        XCTAssertEqual(flattened, UInt32.max)
    }
    
    func testFlattenUInt8ToUInt16() {
        let byteArray: [UInt8] = [UInt8.max, UInt8.max]
        let flattened: UInt16 = flatten(byteArray)
        XCTAssertEqual(flattened, UInt16.max)
    }
    
    func testFlattenUInt8ToUInt64() {
        let byteArray: [UInt8] = [UInt8.max, UInt8.max, UInt8.max, UInt8.max, UInt8.max, UInt8.max, UInt8.max, UInt8.max]
        let flattened: UInt64 = flatten(byteArray)
        XCTAssertEqual(flattened, UInt64.max)
    }
    
    func testFlattenUInt16ToUInt32() {
        let byteArray: [UInt16] = [UInt16.max, UInt16.max]
        let flattened: UInt32 = flatten(byteArray)
        XCTAssertEqual(flattened, UInt32.max)
    }
    
    func testFlattenUInt16ToUInt64() {
        let byteArray: [UInt16] = [UInt16.max, UInt16.max, UInt16.max, UInt16.max]
        let flattened: UInt64 = flatten(byteArray)
        XCTAssertEqual(flattened, UInt64.max)
    }
    
    func testFlattenUInt32ToUInt64() {
        let byteArray: [UInt32] = [UInt32.max, UInt32.max]
        let flattened: UInt64 = flatten(byteArray)
        XCTAssertEqual(flattened, UInt64.max)
    }
}

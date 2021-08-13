//
//  EndPointUrlStringTests.swift
//  MobileBuyersGuideTests
//
//  Created by Atikur Rahman on 13/8/21.
//

import XCTest
@testable import MobileBuyersGuide

class EndPointUrlStringTests: XCTestCase {

    func testGetMobilesEndPointURLString() throws {
        let expected = "https://scb-test-mobile.herokuapp.com/api/mobiles"
        let actual = "\(SCBTarget.getMobiles.baseURL)\(SCBTarget.getMobiles.path)"
        XCTAssertEqual(actual, expected)
    }
    
    func testGetImagesEndPointURLString() throws {
        let expected = "https://scb-test-mobile.herokuapp.com/api/mobiles/1/images"
        let actual = "\(SCBTarget.getImages(mobileId: 1).baseURL)\(SCBTarget.getImages(mobileId: 1).path)"
        XCTAssertEqual(actual, expected)
    }
}

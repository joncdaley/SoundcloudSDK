//
//  SoundcloudTests.swift
//  SoundcloudTests
//
//  Created by Kevin DELANNOY on 24/02/15.
//  Copyright (c) 2015 Kevin Delannoy. All rights reserved.
//

import XCTest

class SoundcloudTests: XCTestCase {
    func testCredentialsError() {
        let resolveExpectation = expectationWithDescription("Waiting for `resolve` response")
        Soundcloud.resolve("") { response in
            XCTAssertFalse(response.response.isSuccessful, "The result should be a .Failure")
            XCTAssert(response.response.error! == SoundcloudError.CredentialsNotSet, "Errors should be about Credentials")
            resolveExpectation.fulfill()
        }

        waitForExpectationsWithTimeout(1) { e in
            if let _ = e {
                XCTFail("Expectations should have been fulfilled immediatly")
            }
        }
    }
}

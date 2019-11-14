//
//  DeltaCodecTests.swift
//  DeltaCodecTests
//
//  Created by Ricardo Pereira on 13/11/2019.
//  Copyright © 2019 Ably. All rights reserved.
//

import XCTest

class DeltaCodecSwiftTests: XCTestCase {

    var base: String!
    var baseData: Data!
    var deltaBase64: String!
    var deltaData: Data!
    var expectedDeltaOutput: String!

    override func setUp() {
        base = "fhgj fhgj input0 fhgj fhgj"
        baseData = base.data(using: .utf8)!

        deltaBase64 = "1sPEAAABGgAQHgAFBAIxIDEgTx8CGgUAEA=="
        deltaData = Data(base64Encoded: deltaBase64)!

        expectedDeltaOutput = "fhgj fhgj input1 fhgj fhgj 1 O"
    }

    func testBasicDecode() {
        XCTAssertTrue(ARTDeltaCodec.isDelta(deltaData))

        let codec = ARTDeltaCodec()
        codec.setBase(baseData, withId: "m1")

        do {
            let outputData = try codec.applyDelta(deltaData, deltaId: "m2", baseId: "m1")
            let output = String(data: outputData, encoding: .utf8)
            XCTAssertTrue(output == expectedDeltaOutput)
        }
        catch {
            XCTFail("Failed with \(error)")
        }
    }

}

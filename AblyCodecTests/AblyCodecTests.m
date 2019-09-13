//
//  AblyCodecTests.m
//  AblyCodecTests
//
//  Created by Ricardo Pereira on 05/09/2019.
//  Copyright © 2019 Ably. All rights reserved.
//

#import <XCTest/XCTest.h>

@import AblyCodec;

@interface AblyCodecTests : XCTestCase

@end

@implementation AblyCodecTests {
    NSString *base;
    NSData *baseData;
    NSString *deltaBase64;
    NSData *deltaData;
    NSString *expectedDeltaOutput;
}

- (void)setUp {
    base = @"fhgj fhgj input0 fhgj fhgj";
    baseData = [base dataUsingEncoding:NSUTF8StringEncoding];

    deltaBase64 = @"1sPEAAABGgAQHgAFBAIxIDEgTx8CGgUAEA==";
    deltaData = [[NSData alloc] initWithBase64EncodedString:deltaBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];

    expectedDeltaOutput = @"fhgj fhgj input1 fhgj fhgj 1 O";
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testIsDelta {
    XCTAssertTrue([ARTDeltaCodec isDelta:deltaData]);

    deltaData = [[NSData alloc] initWithBase64EncodedString:@"foo" options:0];
    XCTAssertFalse([ARTDeltaCodec isDelta:deltaData]);

    deltaData = nil;
    XCTAssertFalse([ARTDeltaCodec isDelta:deltaData]);
}

- (void)testBasicDecode {
    NSError *error;
    ARTDeltaCodec *codec = [[ARTDeltaCodec alloc] init];
    [codec setBase:baseData withId:@"m1"];

    NSData *outputData = [codec applyDelta:deltaData deltaId:@"m2" baseId:@"m1" error:&error];
    NSString *output = [[NSString alloc] initWithData:outputData encoding:NSUTF8StringEncoding];

    XCTAssertNil(error);
    XCTAssertTrue([output isEqualToString:expectedDeltaOutput]);
}

- (void)testDecodeWithNoBase {
    NSError *error;
    ARTDeltaCodec *codec = [[ARTDeltaCodec alloc] init];
    NSData *output = [codec applyDelta:[NSData new] deltaId:@"m2" baseId:@"m1" error:&error];
    XCTAssertNil(output);
    XCTAssertNotNil(error);
    XCTAssertEqual(error.code, ARTDeltaCodecCodeErrorUninitializedDecoder);
}

- (void)testDecodeWithInvalidDelta {
    NSError *error;
    ARTDeltaCodec *codec = [[ARTDeltaCodec alloc] init];
    [codec setBase:baseData withId:@"m1"];
    NSData *output = [codec applyDelta:[NSData new] deltaId:@"m2" baseId:@"m1" error:&error];
    XCTAssertNil(output);
    XCTAssertNotNil(error);
    XCTAssertEqual(error.code, ARTDeltaCodecCodeErrorInvalidDeltaData);
}

- (void)testDecodeWithMismatchBaseId {
    NSError *error;
    ARTDeltaCodec *codec = [[ARTDeltaCodec alloc] init];
    [codec setBase:baseData withId:@"m1"];
    NSData *output = [codec applyDelta:[NSData new] deltaId:@"m2" baseId:@"foo" error:&error];
    XCTAssertNil(output);
    XCTAssertNotNil(error);
    XCTAssertEqual(error.code, ARTDeltaCodecCodeErrorBaseIdMismatch);
}

@end
